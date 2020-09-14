class MedicationsController < ApplicationController
  def new; end

  def search
    results = SEARCH_RESULTS.med_search_results(med_params[:brand_name])
    return @med_hash = results unless results.nil?
    flash[:warning] = "Sorry, your search did not return any results. Please try another search."
    redirect_to '/medications/new'
  end

  def create
    medication = current_user.medications.create(med_params)
    symptoms = SEARCH_RESULTS.extract_symptoms(medication.product_ndc)
    unless symptoms.nil?
      medication.save_symptoms(symptoms)
      flash[:success] = "#{medication.brand_name} has been added to your medication list!"
    end
    redirect_to '/dashboard'
  end

  def edit
    @medications = current_user.medications.all
  end

  def destroy
    current_user.medications.destroy(med_params[:id])
    Medication.destroy(med_params[:id])
    redirect_to '/medications/edit'
    flash[:notice] = "#{med_params[:brand_name]} was deleted"
  end

  private
  SEARCH_RESULTS ||= SearchResultsFacade.new

  def med_params
    params.permit(:id, :brand_name, :product_ndc)
  end
end
