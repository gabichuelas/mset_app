class SessionsController < ApplicationController
  def omniauth
    require "pry"; binding.pry
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      redirect_to '/login'
    end
  end
end
