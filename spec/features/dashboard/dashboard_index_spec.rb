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
    before :each do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'In the profile section, I see my birthdate and my weight' do
      within('.profile') do
        expect(page).to have_content("1985-09-01")
      end
    end

    it "If I don\'t have any meds on my list, the medications list section has a note that indicates this and an 'Add Medications' button" do
      within('.med-list') do
        expect(page).to have_content("You don't have any saved medications.")
        expect(page).to have_button("Add Medications")
      end
    end

    xit 'If I do have meds on my list, the medications list section displays the list and has an edit button' do
      # create(:user_medication, user: @user)
      @user.medications.create!(brand_name: "Adderall", generic_name: "generic", product_ndc: "123-123")
      within('.med-list') do
        expect(page).to have_content("Adderall")
        expect(page).to have_button("Edit Medication List")
      end
    end

    it 'There is a form to log a new symptom' do
      within('.log-form') do
        expect(page).to have_css('#symptom')
        # ^ this will change to be a dropdown menu once a user's medication_symptoms are accessible
        expect(page).to have_css('#when')
        expect(page).to have_css('#note')
        expect(page).to have_button('Save')
      end
    end
  end
end
