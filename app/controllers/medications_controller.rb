require 'nokogiri'
require 'open-uri'

class MedicationsController < ApplicationController
  def new
  end

  def search
    conn = Faraday.new('https://api.fda.gov')
    response = conn.get("https://api.fda.gov/drug/ndc.json?search=brand_name_base:#{params[:medication_name]}&limit=10")
    json = JSON.parse(response.body, symbolize_names: true)
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

    unless tables[0].nil?
      symptoms = []
      tables.each do |table|
        table.each do |t|
          page = Nokogiri::XML(t)
          page.css('tbody').select do |node|
            node.traverse do |el|
              # require "pry"; binding.pry if el.name == 'footnote'
              symptoms << el.text.strip unless el.text.include?('%') || el.text.downcase == 'gastrointestinal disorders' || el.text.downcase.include?('system') || el.text.downcase.strip == 'general' || el.text.downcase.strip == 'metabolic/nutritional' || el.text.downcase == 'urogenital' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.downcase.include?('only') || el.text.downcase.include?('adverse') || el.text.downcase.include?('reaction') || el.text.downcase.include?('adverse event') || el.text.downcase.include?('placebo') || el.text=~ /\d/
            end
          end
        end
      end
      symptoms.uniq!
      symptoms.delete("") if symptoms.include?("")
      symptoms.delete(medication.brand_name) if symptoms.include?(medication.brand_name)
      # p symptoms

      symptoms.each do |symptom|
        symptom = Symptom.create(description: symptom)
        # symptom.save
        MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
        # med_sym.save
      end
    end
    redirect_to '/dashboard'
  end

  def edit
    @medications = current_user.medications.all
  end

  def destroy
    Medication.destroy(med_params[:id])
    redirect_to '/medications/edit'
    flash[:warning] = "#{med_params[:name]} was deleted"
  end

  private

  def med_params
    params.permit(:id, :name, :product_ndc)
  end
end
