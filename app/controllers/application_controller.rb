class ApplicationController < ActionController::Base

  before_filter :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do
      |u| u.permit(:first_name, :last_name, :full_name, :email, :password,
                   :password_confirmation, :class_code, :school, :city, :state,
                   :country)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def current_course
    current_course ||= Course.where("id = ? AND teacher_id = ?", params[:course].to_i, current_teacher.id).last
  end
    
  helper_method :current_course
end
