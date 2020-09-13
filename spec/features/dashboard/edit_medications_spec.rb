RSpec.describe 'User can edit the medication list', type: :feature do
  before :each do
    @user = create(:user)
  end
  it 'I can add medication' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'

    # When I click the <add medications "Here"> button
    expect(page).to have_button('Add New Medication')
    click_on('Add New Medication')

    expect(current_path).to eq('/medications/new')
    # When I search for "adderall"
    expect(page).to have_content("Enter brand medication name")

    fill_in :medication_name, with: 'Adderall'
    click_on 'Find Medication'

    expect(current_path).to eq('/medications/search')

    expect(page).to have_content('Please select the correct medication brand name')

    within('.medications', match: :first) do
      expect(page).to have_button('Adderall XR')
      click_on 'Adderall XR'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Adderall XR')

    expect(page).to have_button('Edit Medication List')
    click_on 'Edit Medication List'

    expect(current_path).to eq('/medications/edit')

    expect(page).to have_content('Adderall XR')

    within('.medications', match: :first) do
      expect(page).to have_button('Delete')
      click_on 'Delete'
    end
    save_and_open_page
    expect(page).to have_content('Adderall XR was deleted')

    visit '/dashboard'
    expect(page).to_not have_content('Adderall XR')
  end
end
