require 'rails_helper'

RSpec.describe 'As an authenticated user, I can view all my symptom logs on one page' do
  before :each do
    @user = create(:user)

    @symptom_1 = Symptom.create!(description: "Headache")
    @symptom_2 = Symptom.create!(description: "Insomnia")
    @symptom_3 = Symptom.create!(description: "Death")

    @log_1_time = DateTime.new(2004,2,3,4,5,0, '+6:00') # second, headache
    @log_1 = Log.create(user: @user, symptom: @symptom_1, when: @log_1_time)

    @log_2_time = DateTime.new(2003,2,3,4,5,0, '+6:00') # third, insomnia
    @log_2 = Log.create(user: @user, symptom: @symptom_2, when: @log_2_time)

    @log_3_time = DateTime.new(2005,2,3,4,5,0, '+6:00') # first, death
    @log_3 = Log.create(user: @user, symptom: @symptom_3, when: @log_3_time, note: 'make it stop!!!!')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'I can visit the logs index page via a button in the logs section on the dashboard' do
    visit dashboard_path

    within('.log-list') do
      click_on 'See All Logs'
    end

    expect(current_path).to eq('/logs')

    within(first('.log')) do
      expect(page).to have_css('.symptom')
      symptom = find('.symptom').text
      expect(symptom).to eq(@symptom_3.description)

      expect(page).to have_css('.when')
      when_experienced = find('.when').text
      expect(when_experienced).to eq("2005-02-02 22:05:00 UTC")

      expect(page).to have_css('.note')
      note = find('.note').text
      expect(note).to eq(@log_3.note)
    end
  end

  it 'I can visit the logs index page via a button in the nav bar' do

  end
end
