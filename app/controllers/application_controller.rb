class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # Permit username and private attributes
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :private])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :private])
  end
  
  def ensure_authorized
    unless current_user && authorized?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end
