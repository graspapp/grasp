class SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate(auth_options)
    resource_name = self.resource_name

    if resource.nil?
      resource_name = :student
      request.params[:student] = params[:teacher]
      self.resource = warden.authenticate!(auth_options.merge(scope: :student))
    end

    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end
