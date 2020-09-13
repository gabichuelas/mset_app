require 'nokogiri'
require 'open-uri'

class MedicationsController < ApplicationController
  def new
  end

  def search
    results = SEARCH_RESULTS.med_search_results(params[:medication_name])
    return @med_hash = results unless results.nil?
    flash[:warning] = "Sorry, your search did not return any results. Please try another search."
    redirect_to '/medications/new'
  end

  def create
    medication = current_user.medications.create(med_params)
    
    # GETTING SYMPTOMS
    response = MSET_SERVICE.sym_search(medication.product_ndc)
    json = json_parse(response)

    tables = json[:results].map do |result|
      result[:adverse_reactions_table]
    end

    unless tables[0].nil?
      symptoms = []
      tables.each do |table|
        table.each do |t|
          page = Nokogiri::XML(t)
          page.css('tbody').select do |node|
            node.traverse do |el|
              # require "pry"; binding.pry if el.name == 'footnote'
              symptoms << el.text.strip unless el.text.include?('%') || el.text.include?('System') || el.text.strip == 'General' || el.text.strip == 'Metabolic/Nutritional' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.include?('only') || el.text=~ /\d/
            end
          end
        end
      end
      symptoms.uniq!
      symptoms.delete("") if symptoms.include?("")

      symptoms.each do |symptom|
        symptom = Symptom.create(description: symptom)
        MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
      end
    end
    flash[:success] = "#{medication.brand_name} has been added to your medication list!"
    redirect_to '/dashboard'
  end

  private

  def med_params
    params.permit(:brand_name, :product_ndc)
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  MSET_SERVICE = MsetService.new
  SEARCH_RESULTS = SearchResultsFacade.new
end
