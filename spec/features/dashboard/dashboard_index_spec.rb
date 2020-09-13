require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @user = create(:user)
  end

  it 'I cannot access the dashboard without logging in' do
    error_404 = "The page you were looking for doesn't exist."

    visit dashboard_path
    expect(page).to have_content(error_404)
  end

  it 'On my dashboard, I see:
      - profile section
      - medications list section
      - log a symptom section
      - recent logs section
      - logout button' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
    expect(page).to have_css('.profile')
    expect(page).to have_css('.med-list')
    expect(page).to have_css('.log-form')
    expect(page).to have_css('.recent-logs')
    expect(page).to have_content('Sign Out')
  end

  it 'In the profile section, I see my birthdate and my weight' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path
    expect(page).to have_content("1985-09-01")
  end

  it 'In the profile section, a note about birthdate and weight not being saved appears if I didn\'t include those in my profile' do
    user = create(:user, birthdate: nil, weight: nil)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    within('.profile') do
      expect(page).to have_content("Date of birth: not saved")
      expect(page).to have_content("Weight: not saved")
    end
  end
end
