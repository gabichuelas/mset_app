class MedicationsController < ApplicationController
  def new
  end

  def search
    conn = Faraday.new('https://api.fda.gov')
    response = conn.get("https://api.fda.gov/drug/ndc.json?search=brand_name_base:#{params[:medication_name]}&limit=10")
    json = JSON.parse(response.body, symbolize_names: true)
    @med_hash = Hash.new(0)
    json[:results].each do |result|
      @med_hash[result[:brand_name]] = result[:product_ndc]
    end
  end

  def create
    medication = Medication.create(brand_name: params[:name], product_ndc: params[:product_ndc])
    UserMedication.create(user_id: current_user.id, medication_id: medication.id)
    redirect_to '/dashboard'
  end
end
