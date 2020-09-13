require 'nokogiri'
require 'open-uri'

class MedicationsController < ApplicationController
  def new
  end

  def search
    response = MSET_SERVICE.med_search(params[:medication_name])
    json = json_parse(response)

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

    response = MSET_SERVICE.sym_search(medication.product_ndc)
    json = json_parse(response)

    tables = json[:results].map do |result|
      result[:adverse_reactions_table]
    end
    # require "pry"; binding.pry
    if !tables.nil?
      # symptoms = []
      symptoms = tables.reduce([]) do |acc, table|
        require "pry"; binding.pry
        table.each do |t|
          get_symptom(acc, t)
        end
        acc
      end
      symptoms.uniq!

      symptoms.each do |symptom|
        symptom = Symptom.create(description: symptom)
        # symptom.save
        MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
        # med_sym.save
      end
      redirect_to '/dashboard'
    else
      redirect_to '/dashboard'
    end
  end

  def get_symptom(acc, table)
    page = Nokogiri::XML(table)
    page.css('tbody').select do |node|
      node.traverse do |el|
        if el.name == 'footnote'
          acc << el.text.strip unless el.text.include?('%') || el.text.include?('System') || el.text.strip == 'General' || el.text.strip == 'Metabolic/Nutritional' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.include?('only') || el.text=~ /\d/
        else
        end
      end
    end
  end

  private

  def med_params
    params.permit(:name, :product_ndc)
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  MSET_SERVICE = MsetService.new
end
