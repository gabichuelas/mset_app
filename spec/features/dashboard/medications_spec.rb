#
# When I click the <add medications "Here"> button,
# I am redirected to a page with a text field to search medications by name.
#

# A maximum of 10 search results are displayed,
# And I can select the specific medication I'd like to add to my medication list by clicking "Save medication."

RSpec.describe 'User can add a medication by name', type: :feature do
  it 'I can add medication' do
    visit '/'

    # When I click the <add medications "Here"> button
    expect(page).to have_link('Add Medication')
    click_on('Add Medication')

    expect(current_path).to eq('/medications/new')
    # When I search for "adderall"
    save_and_open_page
    expect(page).to have_content("Enter brand medication name")

    fill_in :medication_name, with: 'Adderall'
  end
end
