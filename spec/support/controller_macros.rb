module ControllerMacros
  %w(Student Teacher).each do |r|
    define_method "login_as_#{ r.underscore }" do
      user = FactoryGirl.create(r.underscore.to_sym)
      sign_in user.user
      user
    end
  end
end
