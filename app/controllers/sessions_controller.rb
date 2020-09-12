class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']
    user = User.find_by(uid: user_info[:uid])
    if user
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to '/onboarding'
    end
  end
end
