class UsersController < ApplicationController
  before_action :require_user

  def update
    if missing_name?(user_params)
      flash[:error] = 'You must save a first and last name'
      redirect_to request.referer
    else
      current_user.update(user_params)
      if current_user.save
        flash[:success] = 'Account details updated!'
        redirect_to '/dashboard'
      end
    end
  end

  def edit; end

  private

  def user_params
    params.permit(:first_name, :last_name, :birthdate, :weight)
  end

  def missing_name?(user_params)
    user_params[:first_name].empty? || user_params[:last_name].empty?
  end
end
