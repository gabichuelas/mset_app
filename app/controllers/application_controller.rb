class ApplicationController < ActionController::Base

  # CODE WE WILL NEED TO IMPLEMENT CURRENT_USER ONCE
  # SESSIONS CONTROLLER EXISTS, ETC.

  # helper_method :current_user
  #
  # def current_user
  #   @current_user ||= User.find_by(user_id: session[:user_id]) if session[:user_id]
  # end
  #
  # def require_login
  #   render file: '/public/404' unless current_user
  # end
end
