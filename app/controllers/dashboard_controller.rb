class DashboardController < ApplicationController
  before_action :require_user

  def index
    @potential_symptoms = Symptom.potential_symptoms(current_user)
  end
end
