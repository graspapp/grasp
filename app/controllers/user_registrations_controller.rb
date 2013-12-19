class UserRegistrationsController < Devise::RegistrationsController
  # Modified from http://stackoverflow.com/questions/7299618/multiple-user-models-with-ruby-on-rails-and-devise-to-have-seperate-registration
  def create
    build_resource sign_up_params

    child_class = params[:user][:role_type].camelize.constantize
    resource.role = child_class.new(params[child_class.to_s.underscore.to_sym])

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice,
          :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource,
          location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end
