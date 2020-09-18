# require 'rails_helper'
#
# RSpec.describe 'As an authenticated user, when I visit my dashboard,' do
#   before :each do
#     @user = create(:user)
#     medication = create(:medication)
#     symptom_1 = Symptom.create!(description: "Headache")
#     symptom_2 = Symptom.create!(description: "Insomnia")
#     MedicationSymptom.create!(medication: medication, symptom: symptom_1)
#     MedicationSymptom.create!(medication: medication, symptom: symptom_2)
#     UserMedication.create!(user: @user, medication: medication)
#
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
#
#     visit dashboard_path
#   end
#
#   it 'I can log a new symptom, and see a flash message confirming the new log as well as the log displayed in the recent logs section' do
#     within('.log-form') do
#       fill_in :symptom, with: "Headache"
#       save_and_open_page
#       click_button "Search for Symptom"
#     end
#     user = User.find(@user.id)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     # expect(current_path).to eq('/symptoms/search')
#     expect(page).to have_content('What symptom did you experience?')
#     save_and_open_page
#     choose(option: 'Headache')
#     fill_in :when, with: "2020-09-13T23:09"
#     fill_in :note, with: "7/10 pain scale"
#     expect(page).to have_button('Save')
#     click_on 'Save'
#
#     expect(current_path).to eq(dashboard_path)
#     expect(page).to have_content("New symptom logged!")
#
#     within('.recent-logs') do
#       expect(page).to have_content("Headache")
#       expect(page).to have_content("2020-09-13 23:09:00 UTC")
#       expect(page).to have_content("7/10 pain scale")
#     end
#   end
#
#   it 'I can successfully log a new symptom without including a note' do
#     within('.log-form') do
#       fill_in :symptom, with: "Headache"
#       click_button "Search for Symptom"
#     end
#     user = User.find(@user.id)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     # expect(current_path).to eq('/symptoms/search')
#     expect(page).to have_content('What symptom did you experience?')
#     choose(option: 'Headache')
#     fill_in :when, with: "2020-09-13T23:09"
#     expect(page).to have_button('Save')
#     click_on 'Save'
#
#     expect(current_path).to eq(dashboard_path)
#     expect(page).to have_content("New symptom logged!")
#
#     within('.recent-logs') do
#       expect(page).to have_content("Headache")
#       expect(page).to have_content("2020-09-13 23:09:00 UTC")
#     end
#   end
#
#   it 'If I try to log a new symptom without selecting a symptom, I receive an error' do
#     within('.log-form') do
#       click_button "Search for Symptom"
#     end
#
#     expect(current_path).to eq(dashboard_path)
#     expect(page).to have_content('Please be sure to specify a symptom')
#   end
#
#   it 'If I try to log a new symptom without selecting a date/time, I receive an error' do
#     within('.log-form') do
#       fill_in :symptom, with: "Headache"
#       click_button "Search for Symptom"
#     end
#     user = User.find(@user.id)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     expect(current_path).to eq('/symptoms/search')
#     expect(page).to have_content('What symptom did you experience?')
#     choose(option: 'Headache')
#     expect(page).to have_button('Save')
#     click_on 'Save'
#
#     expect(current_path).to eq(symptoms_search_path)
#     expect(page).to have_content('Please be sure to specify a symptom and when you experienced it')
#   end
#
#   it 'If I try to log a new symptom without selecting a symptom and date/time, I receive an error' do
#     within('.log-form') do
#       fill_in :symptom, with: "Headache"
#       click_button "Search for Symptom"
#     end
#     user = User.find(@user.id)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     expect(current_path).to eq('/symptoms/search')
#     expect(page).to have_content('What symptom did you experience?')
#     expect(page).to have_button('Save')
#     click_on 'Save'
#
#     expect(current_path).to eq(symptoms_search_path)
#     expect(page).to have_content('Please be sure to specify a symptom and when you experienced it')
#   end
#
#   it 'I can submit a log for an unlisted symptom' do
#     within('.log-form') do
#       fill_in :symptom, with: "Migraine"
#       click_button "Search for Symptom"
#     end
#
#     expect(current_path).to eq('/symptoms/search')
#     expect(page).to have_content('What symptom did you experience?')
#     choose(option: 'Migraine')
#     fill_in :when, with: "2020-09-13T23:09"
#     expect(page).to have_button('Save')
#     click_on 'Save'
#
#     expect(current_path).to eq(dashboard_path)
#     expect(page).to have_content("New symptom logged!")
#
#     within('.recent-logs') do
#       expect(page).to have_content("Migraine")
#       expect(page).to have_content("2020-09-13 23:09:00 UTC")
#     end
#   end
# end
