module UserRegistrationsHelper
  def setup_resource!(resource)
    params[:user][:role_type] ||= "student"

    if %w(student teacher).include? params[:user][:role_type].downcase
      child_class_name = params[:user][:role_type].downcase.camelize
      role_type = params[:user][:role_type].downcase
    else
      child_class_name = "Student"
      role_type = "student"
    end

    resource.role = child_class_name.constantize.new if resource.role.nil?

    role_type
  end
end
