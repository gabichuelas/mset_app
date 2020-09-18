RSpec.describe 'User can edit the medication list', type: :feature do
  before :each do
    @user = create(:user)
  end

  it 'I can visit the edit medication page and delete a medication' do
    VCR.use_cassette('lexapro_search') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'

      expect(page).to have_link('Add New Medication')
      click_on('Add New Medication')

      expect(current_path).to eq('/medications/new')

      expect(page).to have_content("Add New Medication")

      fill_in :brand_name, with: 'Lexapro'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Select Medication')

      within('.medications', match: :first) do
        expect(page).to have_link('Lexapro')
        click_on 'Lexapro'
      end

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Lexapro')
      expect(page).to have_link('Edit Medication List')
      click_on 'Edit Medication List'

      expect(current_path).to eq('/medications/edit')

      expect(page).to have_content('Lexapro')

      within('.section', match: :first) do
        expect(page).to have_link('Delete')
        click_on 'Delete'
      end

      expect(page).to have_content('Lexapro was deleted')

      visit '/dashboard'
      expect(page).to have_content("You don't have any saved medications.")
    end
  end

  it 'I can add a new medication page via the edit meds list page' do
    VCR.use_cassette('lexapro_search') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'

      expect(page).to have_link('Add New Medication')
      click_on('Add New Medication')

      expect(current_path).to eq('/medications/new')

      expect(page).to have_content("Add New Medication")

      fill_in :brand_name, with: 'Lexapro'
      click_on 'Find Medication'

      expect(current_path).to eq('/medications/search')

      expect(page).to have_content('Select Medication')

      within('.medications', match: :first) do
        expect(page).to have_link('Lexapro')
        click_on 'Lexapro'
      end

      expect(current_path).to eq('/dashboard')

      expect(page).to have_link('Edit Medication List')
      click_on 'Edit Medication List'

      expect(current_path).to eq('/medications/edit')
      expect(page).to have_link('Add New Medication')
      click_on 'Add New Medication'

      expect(current_path).to eq('/medications/new')
    end
  end
end
