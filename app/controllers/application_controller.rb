class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_url, alert: 'Access denied.'
    else
      redirect_to new_user_session_url, alert: 'Access denied.'
    end
  end

end
