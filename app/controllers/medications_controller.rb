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
        @med_hash[result[:brand_name]] = result[:product_ndc]
      end
    end
  end


  def create
    medication = Medication.create(brand_name: med_params[:name], generic_name: 'unknown', product_ndc: med_params[:product_ndc])
    user_med = UserMedication.create(user_id: current_user.id, medication_id: medication.id)
    medication.save
    user_med.save
    # require "pry"; binding.pry
    redirect_to '/dashboard'
  end

  def med_params
    params.permit(:name, :product_ndc)
  end
end
