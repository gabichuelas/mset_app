require 'rails_helper'

RSpec.describe 'As an authenticated user, when I visit my dashboard,' do
  it 'I can log a new symptom, and see a flash message confirming the new log as well as the log displayed in the recent logs section' do
    user = create(:user)
    medication = create(:medication)
    symptom_1 = Symptom.create!(description: "Headache")
    symptom_2 = Symptom.create!(description: "Insomnia")
    MedicationSymptom.create!(medication: medication, symptom: symptom_1)
    MedicationSymptom.create!(medication: medication, symptom: symptom_2)
    UserMedication.create!(user: user, medication: medication)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
    within('.log-form') do
      select "Headache", from: :symptom
      fill_in :when, with: "2020-09-13T23:09"
      fill_in :note, with: "7/10 pain scale"
      click_button "Save"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("New symptom logged!")

    within('.recent-logs') do
      expect(page).to have_content("Headache")
    end
  end
end
