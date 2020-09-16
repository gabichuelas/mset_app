RSpec.describe 'User can logout' do
  scenario 'by clicking a link in the nav bar and is redirected to the welcome page' do
    User.create(uid: '20934801984', email: 'joe@joe.joe', first_name: 'Joe', last_name: 'Doe', access_token: 'aslkdjflkasjf')

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider    => 'google_oauth2',
      :uid         => '20934801984',
      :info        => { :email => 'joe@joe.joe', :first_name => 'Joe', :last_name => 'Doe' },
      :credentials => { :token => 'aslkdjflkasjf' }
    })

    visit '/'

    click_button 'Get Started with Google Login'

    expect(current_path).to eq('/dashboard')

    within '.navbar-text' do
      expect(page).to have_link('Sign Out')
      click_link 'Sign Out'
    end

    expect(current_path).to eq('/')
    expect(page).to have_button('Get Started with Google Login')

    visit '/dashboard'
    expect(page.status_code).to eq(404)
    expect(page).to have_content('The page you were looking for doesn\'t exist')
  end
end
