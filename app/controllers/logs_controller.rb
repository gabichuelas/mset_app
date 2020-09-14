class LogsController < ApplicationController
  def create
    symptom = Symptom.find_by(description: params[:symptom])
    log = Log.create!(user: current_user, symptom: symptom, note: params[:note], when: params[:when])
    if log.save
      flash[:success] = "New symptom logged!"
      redirect_to dashboard_path
    end
  end
end
