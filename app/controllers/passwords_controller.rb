class PasswordsController < Devise::PasswordsController
  def new
    super
  end
  
  def create
    self.resource = Teacher.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    #if Teacher is found send the email
    if successfully_sent?(resource)
      respond_with({}, :location =>
       after_sending_reset_password_instructions_path_for(resource_name))
    
    #if no teacher is found, search students  
    elsif !successfully_sent?(resource)
      self.resource = Student.send_reset_password_instructions(resource_params)
      yield resource if block_given?
      
      #if student is found send email to student
      if successfully_sent?(resource)
         respond_with({}, :location =>
          after_sending_reset_password_instructions_path_for(resource_name))
       else
         #Display error if no email is found
        respond_with(resource)
      end
    end
  end
  
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    sign_in_path if is_navigational_format?
  end
end