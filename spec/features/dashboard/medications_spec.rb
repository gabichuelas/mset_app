RSpec.describe 'User can add a medication by name', type: :feature do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'
    click_on('Add New Medication')
  end

  it 'I can add medication' do
    VCR.use_cassette('adderall_search') do

      expect(current_path).to eq('/medications/new')
      expect(page).to have_content("Enter brand medication name")

      fill_in :brand_name, with: 'Adderall'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Please select the correct medication brand name')

      within('.medications', match: :first) do
        expect(page).to have_button('Adderall XR')
        click_on 'Adderall XR'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Adderall XR')
      expect(page).to have_content("Adderall XR has been added to your medication list!")
    end
  end

  it "When I add a new medication, that medication's side effects are also saved to the database" do
    VCR.use_cassette('adderall_search') do

      fill_in :brand_name, with: 'Adderall'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Please select the correct medication brand name')

      within('.medications', match: :first) do
        expect(page).to have_button('Adderall XR')
        click_on 'Adderall XR'
      end

      adderall_xr = Medication.last

      expect(adderall_xr.brand_name).to eq('Adderall XR')
      adderall_symptoms = MedicationSymptom.where(medication_id: adderall_xr.id)
      expect(adderall_symptoms.empty?).to eq(false)
    end
  end

  xit "Edge case: When I add a new medication without an adverse_reactions_table, user is redirected to dashboard and no symptoms are added" do
    VCR.use_cassette('hand_sanitizer_search') do

      fill_in :brand_name, with: 'hand sanitizer'
      click_on 'Find Medication'

      within('.medications', match: :first) do
        click_on 'HAND SANITIZER'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('HAND SANITIZER')

      expect(@user.potential_symptoms).to be_empty
    end
  end

  it "SAD PATH: Medications aren't duplicated in the user_medications table if user tries to add them twice" do

    VCR.use_cassette('adderall_search_2') do

      fill_in :brand_name, with: 'Adderall'
      click_on 'Find Medication'

      within('.medications', match: :first) do
        click_on 'Adderall'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Adderall')

      VCR.use_cassette('adderall_search_3') do
        click_on('Add New Medication')

        fill_in :brand_name, with: 'Adderall'
        click_on 'Find Medication'

        within('.medications', match: :first) do
          click_on 'Adderall'
        end

        expect(current_path).to eq('/medications/new')
        expect(page).to have_content("Sorry, you've already added Adderall to your list!")
      end
    end
  end

  it 'If I enter an invalid medication, I see a flash message and am redirected to the search page' do
    VCR.use_cassette('nonexistant_med_search') do

      expect(current_path).to eq('/medications/new')
      expect(page).to have_content('Enter brand medication name')

      fill_in :brand_name, with: 'spiro'
      click_on 'Find Medication'
      expect(page).to have_content('Sorry, your search did not return any results. Please try another search.')
    end
  end

  it 'I can click a button to return to my dashboard' do
    expect(page).to have_button('Back to Dashboard')

    click_button 'Back to Dashboard'

    expect(current_path).to eq('/dashboard')
  end
end
