require 'rails_helper'

RSpec.describe 'When I visit the dashboard as an authenticated user' do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end

  it 'I can click on the name of a medication and see that medication\'s show page' do
    VCR.use_cassette('adderall_search') do
      click_on 'Add New Medication'

      expect(current_path).to eq('/medications/new')
      expect(page).to have_content("Enter medication brand name")

      fill_in :brand_name, with: 'Adderall'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Please select the correct medication brand name')

      within('.medications', match: :first) do
        expect(page).to have_button('Adderall XR')
        click_on 'Adderall XR'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_link('Adderall XR')

      adderall_xr = Medication.find_by(brand_name: 'Adderall XR')

      click_on 'Adderall XR'

      expect(current_path).to eq("/medications/#{adderall_xr.id}")

      expect(page).to have_content("Brand Name: Adderall XR")
      expect(page).to have_content('Potential Side Effects:')
      within('.side-effects') do
        expect(page).to have_content('Weight Loss')
        expect(page).to have_content('Abdominal Pain (stomachache)')
        expect(page).to have_content('Loss of Appetite')
        expect(page).to have_content('Insomnia')
        expect(page).to have_content('Nervousness')
        expect(page).to have_content('Headache')
        expect(page).to have_content('Asthenia')
        expect(page).to have_content('Tachycardia')
        expect(page).to have_content('Urinary Tract Infection')
      end
    end
  end
  it "I can delete a medication from my list from the medication show page" do
    VCR.use_cassette('adderall_search') do
      click_on 'Add New Medication'

      expect(current_path).to eq('/medications/new')
      expect(page).to have_content("Enter medication brand name")

      fill_in :brand_name, with: 'Adderall'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Please select the correct medication brand name')

      within('.medications', match: :first) do
        expect(page).to have_button('Adderall XR')
        click_on 'Adderall XR'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_link('Adderall XR')

      adderall_xr = Medication.find_by(brand_name: 'Adderall XR')

      click_on 'Adderall XR'

      expect(current_path).to eq("/medications/#{adderall_xr.id}")

      click_on 'Delete Medication from my List'

      visit dashboard_path

      expect(page).to_not have_content('Adderall XR')
    end
  end
end
