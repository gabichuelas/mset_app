class LogsController < ApplicationController
  def create
    require "pry"; binding.pry
    symptom = Symptom.find_by(description: log_params[:symptom])
    log = Log.create(user: current_user, symptom: symptom, note: log_params[:note], when: log_params[:when])
    if log.save
      flash[:success] = 'New symptom logged!'
      redirect_to dashboard_path
    elsif no_symptom? || no_when?
      flash[:error] = 'Please be sure to specify a symptom and when you experienced it'
      redirect_to request.referer
    end
  end

  private

  def log_params
    params.permit(:symptom, :when, :note)
  end

  def no_symptom?
    params[:symptom].nil? || params[:symptom].empty?
  end

  def no_when?
    params[:when].nil? || params[:when].empty?
  end
end
