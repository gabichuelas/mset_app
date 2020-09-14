class LogsController < ApplicationController
  def create
    symptom = Symptom.find_by(description: params[:symptom])
    log = Log.create(user: current_user, symptom: symptom, note: params[:note], when: params[:when])
    if log.save
      flash[:success] = 'New symptom logged!'
      redirect_to dashboard_path
    elsif no_symptom?
      flash[:error] = 'Please specify a symptom'
      redirect_to request.referer
    elsif no_when?
      flash[:error] = 'Please specify when you experienced this symptom'
      redirect_to request.referer
    elsif no_symptom? && no_when?
      flash[:error] = 'Please specify a symptom and when you experienced it'
      redirect_to request.referer
    end
  end

  private

  def user_params
    params.permit(:symptom, :when, :note)
  end

  def no_symptom?
    params[:symptom].nil? || params[:symptom].empty?
  end

  def no_when?
    params[:when].nil? || params[:when].empty?
  end
end
