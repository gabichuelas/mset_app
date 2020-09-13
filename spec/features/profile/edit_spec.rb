require 'rails_helper'

RSpec.describe 'When I visit the dashboard as an authenticated usr' do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
  end

  it 'I can click a link to edit my profile data and am redirected to a form where I can update my info' do
    within('.profile') do
      click_button "Edit Profile"
    end
    expect(current_path).to eq(profile_edit_path)
    expect(page).to have_css('#first_name')
    expect(page).to have_css('#last_name')
    expect(page).to have_css('#birthdate')
    expect(page).to have_css('#weight')
  end

  it 'I can successfully edit my profile' do
    within('.profile') do
      click_button "Edit Profile"
    end

    expect(current_path).to eq(profile_edit_path)

    fill_in :weight, with: 300
    click_button "Save"
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Account details updated!')
    expect(@user.weight).to eq(300)
    within('.profile') do
      expect(page).to have_content("Weight: 300 lbs")
      expect(page).to have_content("300")
    end
  end

  it 'Unsuccessful profile edit' do

  end
end
