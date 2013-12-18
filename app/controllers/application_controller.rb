class ApplicationController < ActionController::Base
  before_action :configure_devise_params, if: :devise_controller?
  alias_method :devise_current_user, :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def configure_devise_params
    [:sign_up, :account_update].each do |s|
      devise_parameter_sanitizer.for(s) do |u|
        u.permit(:first_name, :last_name, :role_type, :email, :password,
                 :password_confirmation)
      end
    end
  end

  def current_user
    super.role if super
  end
end
