class RegistrationsController < Devise::RegistrationsController
  def sign_up(resource_name, resource)
    sign_in(:user, resource)
  end
end
