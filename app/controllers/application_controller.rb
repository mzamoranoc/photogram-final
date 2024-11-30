class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :authenticate_user!

  def ensure_authorized
    unless current_user && authorized?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end
