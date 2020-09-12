#
# When I click the <add medications "Here"> button,
# I am redirected to a page with a text field to search medications by name.
#

# A maximum of 10 search results are displayed,
# And I can select the specific medication I'd like to add to my medication list by clicking "Save medication."

RSpec.describe 'User can add a medication by name', type: :feature do
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
  end
  it 'If I enter an invalid medication, I see a flash message and am redirected to the search page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit '/dashboard'

    # When I click the <add medications "Here"> button
    expect(page).to have_button('Add New Medication')
    click_on('Add New Medication')

    expect(current_path).to eq('/medications/new')
    # When I search for "adderall"
    expect(page).to have_content('Enter brand medication name')

    fill_in :medication_name, with: 'spiro'
    click_on 'Find Medication'
    save_and_open_page
    expect(page).to have_content('Sorry, your search did not return any results. Please try another search.')
  end
end
