require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @user = create(:user)
  end

  it 'I cannot access the dashboard without logging in' do
    error_404 = "The page you were looking for doesn't exist."

    visit dashboard_path
    expect(page).to have_content(error_404)
  end

  it 'On my dashboard, I see:
      - profile section
      - medications list section
      - log a symptom section
      - recent logs section
      - logout button' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
    expect(page).to have_css('.profile')
    expect(page).to have_css('.med-list')
    expect(page).to have_css('.log-form')
    expect(page).to have_css('.recent-logs')
    expect(page).to have_content('Sign Out')
  end

  describe 'On my dashboard' do
    it 'In the profile section, I see my birthdate and my weight' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within('.profile') do
        expect(page).to have_content(@user.weight)
        expect(page).to have_content(@user.birthdate)
      end
    end

    it "If I don\'t have any meds on my list, the medications list section has a note that indicates this and an 'Add Medications' button" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within('.med-list') do
        expect(page).to have_content("You don't have any saved medications.")
        expect(page).to have_link("Add New Medication")
      end
    end

    it 'If I do have meds on my list, the medications list section displays the list and has an edit button' do
      @user.medications.create!(brand_name: "Adderall", product_ndc: "123-123")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within('.med-list') do
        expect(page).to have_content("Adderall")
        expect(page).to have_link("Edit Medication List")
      end
    end

    it 'There is a form to log a new symptom' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
      within('.log-form') do
        expect(page).to have_css('#symptom')
        expect(page).to have_css('#when')
        expect(page).to have_css('#note')
        expect(page).to have_button('Save')
      end
    end
  end

  it 'In the profile section, a note about birthdate and weight not being saved appears if I didn\'t include those in my profile' do
    user = create(:user, birthdate: nil, weight: nil)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    within('.profile') do
      expect(page).to have_content("Date of birth: not saved")
      expect(page).to have_content("Weight: not saved")
    end
  end

  it 'In the recent-logs section, I see my recently logged symptoms' do
    symptom_1 = Symptom.create!(description: "Headache")
    symptom_2 = Symptom.create!(description: "Insomnia")
    symptom_3 = Symptom.create!(description: "Death")

    log_1_time = DateTime.new(2004,2,3,4,5,0, '+6:00') # second, headache
    log_1 = Log.create(user: @user, symptom: symptom_1, when: log_1_time)

    log_2_time = DateTime.new(2003,2,3,4,5,0, '+6:00') # third, insomnia
    log_2 = Log.create(user: @user, symptom: symptom_2, when: log_2_time)

    log_3_time = DateTime.new(2005,2,3,4,5,0, '+6:00') # first, death
    log_3 = Log.create(user: @user, symptom: symptom_3, when: log_3_time, note: 'make it stop!!!!')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    within('.recent-logs') do
      within(first('.log')) do
        expect(page).to have_css('.symptom')
        symptom = find('.symptom').text
        expect(symptom).to eq(symptom_3.description)

        expect(page).to have_css('.when')
        when_experienced = find('.when').text
        expect(when_experienced).to eq("2005-02-02 22:05:00 UTC")

        expect(page).to have_css('.note')
        note = find('.note').text
        expect(note).to eq(log_3.note)
      end
    end
  end
end
