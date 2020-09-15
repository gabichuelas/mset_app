class DashboardController < ApplicationController
  before_action :require_user

  def index
    @potential_symptoms = current_user.potential_symptoms
  end

  # def fuzzy_search(input)
  #   jarow = FuzzyStringMatch::JaroWinkler.create(:native)
  #   @results = potential_symptoms.select do |symptom|
  #     jarow.getDistance(input.downcase, symptom.downcase) >= 0.85
  #   end
  # end

  
end
