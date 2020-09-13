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
        if @med_hash.keys.include?(result[:brand_name])
          next
        else
          @med_hash[result[:brand_name]] = result[:product_ndc]
        end
      end
    end
  end

  def create
    medication = current_user.medications.create(brand_name: med_params[:name], generic_name: 'unknown', product_ndc: med_params[:product_ndc])

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
    params.permit(:name, :product_ndc)
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  MSET_SERVICE = MsetService.new
end
