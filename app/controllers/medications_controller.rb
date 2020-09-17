class MedicationsController < ApplicationController
  def new; end

  def search
    require "pry"; binding.pry
    results = SEARCH_RESULTS.med_search_results(med_params[:brand_name])
    return @med_results = results unless results.nil?
    flash[:warning] = "Sorry, your search did not return any results. Please try another search."
    redirect_to '/medications/new'
  end

  def create
    medication = Medication.find_or_create_by(med_params)
    if current_user.has_medication?(medication.id)
      flash[:warning] = "Sorry, you've already added #{medication.brand_name} to your list!"
      redirect_to '/medications/new'
    else
      current_user.add_medication(medication.id)
      SEARCH_RESULTS.save_symptoms(medication.id)
      flash[:success] = "#{medication.brand_name} has been added to your medication list!"
      redirect_to '/dashboard'
    end
  end

  def show
    @medication = Medication.find(med_params[:id])
  end

  def edit
    @medications = current_user.medications.all
  end

  def destroy
    current_user.medications.destroy(med_params[:id])
    redirect_to '/medications/edit'
    flash[:notice] = "#{med_params[:brand_name]} was deleted"
  end

  private
  SEARCH_RESULTS ||= SearchResultsFacade.new

  def med_params
    params.permit(:id, :brand_name, :product_ndc)
  end
end
