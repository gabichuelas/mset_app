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
end
