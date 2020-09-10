RSpec.describe 'As a visitor' do
  describe 'when I visit the root path' do
    scenario 'I can register with my Google credentials' do
      OmniAuth.config.test_mode = true

      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider    => 'google_oauth2',
        :uid         => ENV['GOOGLE_UID'},
        :info        => {:email => 'joe@joe.joe'},
        :credentials => {:token => ENV['ACCESS_TOKEN'], :refresh_token => ENV['REFRESH_TOKEN']}
        })

      visit '/'

      click_button 'Log in with Google'

      user = User.last

      expect(user.uid).to eq(ENV['GOOGLE_UID'])
      expect(user.email).to eq('joe@joe.joe')
      expect(user.access_token).to eq(ENV['ACCESS_TOKEN'])
      expect(user.refresh_token).to eq(ENV['REFRESH_TOKEN'])

      expect(current_path).to eq('/onboarding')

      expect(page).to have_content('Please enter some information to get started!')

      fill_in :first_name, with: 'Joe'
      fill_in :last_name, with: 'Doe'
      fill_in :birthdate, with: '1972-09-05'
      fill_in :weight, with: 185

      click_button 'Add Account Info'

      expect(current_path).to eq('/dashboard')

      user.reload!

      expect(page).to have_content('Welcome, Joe Doe!')
    end
  end
end
