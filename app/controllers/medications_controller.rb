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

    # GETTING SYMPTOMS

    response = MSET_SERVICE.sym_search(medication.product_ndc)
    json = json_parse(response)

    tables = json[:results].map do |result|
      if result[:adverse_reactions_table].nil?
        break
      else
        result[:adverse_reactions_table]
      end
    end

    if !tables.nil?
      symptoms = tables.reduce([]) do |acc, table|
        table.each do |t|
          # the following code isn't correct yet,
          # it does not return symptoms.
          # get_symptom(acc, t)
          # ^ defined in a helper method below
        end
        acc
      end
      symptoms.uniq!

      symptoms.each do |symptom|
        symptom = Symptom.create(description: symptom)
        MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
      end
      redirect_to '/dashboard'
    else
      redirect_to '/dashboard'
    end
  end

  # def get_symptom(acc, table)

    # this code doesn't work as expected.
    # explore alternate solution with different endpoint.
    # see #adverse_reactions_table method in SINATRA APP
    # for possible alternative

  #   page = Nokogiri::XML(table)
  #   page.css('tbody').select do |node|
  #     node.traverse do |el|
  #       if el.name == 'footnote'
  #         acc << el.text.strip unless el.text.include?('%') || el.text.include?('System') || el.text.strip == 'General' || el.text.strip == 'Metabolic/Nutritional' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.include?('only') || el.text=~ /\d/
  #       else
  #       end
  #     end
  #   end
  # end

  private

  def med_params
    params.permit(:name, :product_ndc)
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  MSET_SERVICE = MsetService.new
end
