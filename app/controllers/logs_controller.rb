class LogsController < ApplicationController
  def create
    symptom = Symptom.find_by(description: params[:symptom])
    Log.create!(user: current_user, symptom: symptom, note: params[:note], when: params[:when])
    redirect_to dashboard_path
  end
end
