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
    save_and_open_page

    # When I click the <add medications "Here"> button
    expect(page).to have_button('Add New Medication')
    click_on('Add New Medication')

    expect(current_path).to eq('/medications/new')
    # When I search for "adderall"
    expect(page).to have_content("Enter brand medication name")

    fill_in :medication_name, with: 'Adderall'
    click_on 'Find Medication'
  end
end
