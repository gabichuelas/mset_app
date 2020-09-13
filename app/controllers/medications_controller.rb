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
    # tables = SEARCH_RESULTS.adverse_reactions_table(medication.product_ndc)
    # unless tables[0].nil?
    symptoms = SEARCH_RESULTS.extract_symptoms(medication.product_ndc)
    unless symptoms.nil?
      symptoms.each do |symptom|
        symptom = Symptom.create(description: symptom)
        MedicationSymptom.create(medication_id: medication.id, symptom_id: symptom.id)
      end
      flash[:success] = "#{medication.brand_name} has been added to your medication list!"
    end

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
