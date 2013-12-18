Grasp::Application.routes.draw do
  devise_for :users, controllers: { registrations: "user_registrations" }

  devise_scope :user do
    get "student/sign_up" => "user_registrations#new",
      user: { user_type: "student" }
    get "teacher/sign_up" => "user_registrations#new",
      user: { user_type: "student" }
  end

  resources :students

  authenticated :user do
    root to: "students#home", as: :user_root
    #root to: "students#home", as: :student_root
  end

  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home about contact acknowledgements sign_up_selection].each do |page|
    get page, controller: "pages", action: page
  end
end
