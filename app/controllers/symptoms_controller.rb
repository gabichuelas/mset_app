require 'fuzzystringmatch'

class SymptomsController < ApplicationController
  def search
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    symptoms = current_user.medications.map do |med|
      med.symptoms.map do |sym|
        sym.description
      end
    end.flatten

    @results = symptoms.select do |symptom|
      jarow.getDistance(search_params[:symptom].downcase, symptom.downcase) >= 0.855
    end

    @log_hash = {when: search_params[:when], note: search_params[:note]}
  end

  private

  def search_params
    params.permit(:symptom, :when, :note)
  end
end
