class DashboardController < ApplicationController
  before_action :require_user

  def index
    @potential_symptoms = current_user.potential_symptoms
  end
end
