#
# When I click the <add medications "Here"> button,
# I am redirected to a page with a text field to search medications by name.
#
# When I search for "adderall",
# A maximum of 10 search results are displayed,
# And I can select the specific medication I'd like to add to my medication list by clicking "Save medication."

RSpec.describe 'User can add a medication by name', type: :feature do
  before(:each) do
    # As an authenticated user
    visit '/'

    # @ Jessye - this previously did not work because it expected Log In
    expect(page).to have_button('Login')
    # the current_path won't be dashboard bc logging in hasn't happened yet
    # expect(current_path).to eq('/dashboard')
  end
  it 'I can add medication' do
    # When I click the <add medications "Here"> button
  end
end
