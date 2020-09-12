RSpec.describe 'As a visitor' do
  describe 'when I visit the root path' do
    scenario 'I can register with my Google credentials' do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        :provider    => 'google_oauth2',
        :uid         => '20934801984',
        :info        => { :email => 'joe@joe.joe', :first_name => 'Joe', :last_name => 'Doe' },
        :credentials => { :token => 'aslkdjflkasjf' }
      })

      visit '/'

      click_button 'Get Started with Google Login'

      user = User.last

      expect(user.uid).to eq('20934801984')
      expect(user.email).to eq('joe@joe.joe')
      expect(user.first_name).to eq('Joe')
      expect(user.last_name).to eq('Doe')
      expect(user.access_token).to eq('aslkdjflkasjf')

      expect(current_path).to eq('/onboarding')

      expect(page).to have_content('Please enter some information to get started!')

      fill_in :first_name, with: 'Joseph'
      fill_in :last_name, with: 'Dough'
      fill_in :birthdate, with: '1972-09-05'
      fill_in :weight, with: 185

      click_button 'Add Account Info'

      expect(current_path).to eq('/dashboard')

      user.reload
      save_and_open_page

      expect(user.first_name).to eq('Joseph')
      expect(user.last_name).to eq('Dough')
      expect(user.birthdate).to eq('1972-09-05')
      expect(user.weight).to eq(185)

      expect(page).to have_content('Welcome, Joseph Dough!')
      expect(page).to have_content('Account details updated!')
      expect(page).to have_content('Sign Out')
    end
  end
end
