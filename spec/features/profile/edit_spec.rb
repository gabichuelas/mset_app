require 'rails_helper'

RSpec.describe 'When I visit the dashboard as an authenticated usr' do
  it 'I can click a link to edit my profile data and am redirected to a form where I can update my info' do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
    within('.profile') do
      click_button "Edit Profile"
    end
    expect(current_path).to eq('/profile/edit')
    expect(page).to have_css('#first_name')
    expect(page).to have_css('#last_name')
    expect(page).to have_css('#birthdate')
    expect(page).to have_css('#weight')
  end

  it 'Unsuccessful profile edit' do

  end
end
