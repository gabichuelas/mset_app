require 'nokogiri'
require 'open-uri'

class MedicationsController < ApplicationController
  def new
  end

  def search
    # conn = Faraday.new('https://api.fda.gov/')
    # response = conn.get("drug/ndc.json?search=brand_name_base:#{params[:medication_name]}&limit=10")
    # json = JSON.parse(response.body, symbolize_names: true)
    response = MsetService.new.med_search(params[:medication_name])
    json = JSON.parse(response.body, symbolize_names: true)

    # require "pry"; binding.pry

    @med_hash = Hash.new(0)
    if json[:results].nil?
      redirect_to '/medications/new'
      flash[:warning] = "Sorry, your search did not return any results. Please try another search."
    else
      json[:results].each do |result|
        @med_hash[result[:brand_name]] = result[:product_ndc]
      end
    end
  end

  def create
    medication = current_user.medications.create(brand_name: med_params[:name], generic_name: 'unknown', product_ndc: med_params[:product_ndc])
    user_med = UserMedication.create(user_id: current_user.id, medication_id: medication.id)
    # medication.save
    # user_med.save

    conn = Faraday.new('https://api.fda.gov')
    response = conn.get("https://api.fda.gov/drug/label.json?search=openfda.product_ndc.exact:#{medication.product_ndc}")
    json = JSON.parse(response.body, symbolize_names: true)
    # require "pry"; binding.pry
    tables = json[:results].map do |result|
      result[:adverse_reactions_table]
    end
    symptoms = []
    tables.each do |table|
      table.each do |t|
        page = Nokogiri::XML(t)
        page.css('tbody').select do |node|
          node.traverse do |el|
            if el.name == 'footnote'
              symptoms << el.text.strip unless el.text.include?('%') || el.text.include?('System') || el.text.strip == 'General' || el.text.strip == 'Metabolic/Nutritional' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.include?('only') || el.text=~ /\d/
            else
            end
          end
        end
      end
    end
    symptoms.uniq!
    # symptoms.delete("") if symptoms.include?("")
    # p symptoms

    symptoms.each do |symptom|
      symptom = Symptom.create(description: symptom)
      # symptom.save
      MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
      # med_sym.save
    end
    redirect_to '/dashboard'
  end

  def med_params
    params.permit(:name, :product_ndc)
  end
end
