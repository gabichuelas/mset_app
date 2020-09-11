require 'rails_helper'

RSpec.describe 'As an authenticated user' do
  before :each do
    @user = create(:user)
  end

  it 'I am redirected to the dashboard page after logging in.' do
    # test being redirected to dashboard after login - might be covered by Michael's specs already
  end

  it 'On my dashboard, I see:
      - profile section
      - medications list section
      - log a symptom section
      - recent logs section
      - logout button' do

    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit "/dashboard"
    expect(page).to have_css('.profile')
    expect(page).to have_css('.med-list')
    expect(page).to have_css('.log-form')
    expect(page).to have_css('.recent-logs')
    expect(page).to have_button("Logout")
  end

end
