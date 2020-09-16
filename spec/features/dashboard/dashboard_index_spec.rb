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
    
  end
end
