class UserRegistrationsController < Devise::RegistrationsController
  # Modified from http://stackoverflow.com/questions/7299618/multiple-user-models-with-ruby-on-rails-and-devise-to-have-seperate-registration
  def create
    # Getting the user type that is send through a hidden field in the
    # registration form.
    role_type = params[:user][:role_type]

    # Deleting the role_type from the params hash, won't work without this.
    #params[:user].delete(:role_type)
    
    # Building the user, I assume.
    build_resource sign_up_params

    # crate a new child instance depending on the given user type
    child_class = params[:user][:role_type].camelize.constantize
    resource.role = child_class.new(params[child_class.to_s.underscore.to_sym])

    # first check if child instance is valid
    # cause if so and the parent instance is valid as well
    # it's all being saved at once
    valid = resource.valid?
    valid = resource.role.valid? && valid

    if valid && resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        #respond_with resource,
          #location: redirect_location(resource_name, resource)
        redirect_to root_path
      else
        set_flash_message :notice, :inactive_signed_up,
          reason: inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource,
          location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    end
  end
end
