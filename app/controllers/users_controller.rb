class UsersController < ApplicationController
  before_action :require_user

  def update
    current_user.update(user_params)
    if current_user.save
      flash[:success] = 'Account details updated!'
      redirect_to '/dashboard'
    end
  end

  def edit; end

  private

  def user_params
    params.permit(:first_name, :last_name, :birthdate, :weight)
  end
end
