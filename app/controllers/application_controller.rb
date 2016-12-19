class ApplicationController < ActionController::Base
  layout :set_layout
  before_action :check_user_agent
  helper_method :is_mobile?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user_agent
    if params[:device] == 'mobile'|| request.env["HTTP_USER_AGENT"] =~ /(Android|Mobile)/
      request.variant = :mobile
    end
  end

  def is_mobile?
    request.variant.present?
  end

  def after_sign_in_path_for(resource)
    recommender_path
  end

 protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


  private
  def set_layout
    is_mobile? ? "sp" : "pc"
  end

  def sign_in_required_recommender
    redirect_to new_recommender_session_url unless recommender_signed_in?
  end

  def sign_in_required_admin
    redirect_to new_admin_session_url unless admin_signed_in?
  end

end
