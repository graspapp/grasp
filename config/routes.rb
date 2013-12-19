ROLE_TYPES = %w(student teacher)

Grasp::Application.routes.draw do
  devise_for :users, controllers: { registrations: "user_registrations" }

  devise_scope :user do
    ROLE_TYPES.each do |r|
      get "#{ r }/sign_up" => "user_registrations#new", user: { role_type: r }
    end
  end

  ROLE_TYPES.each do |r|
    authenticated :user, lambda { |u| u.role_type == r.capitalize } do
      root to: "#{ r.pluralize }#home", as: "#{ r }_root".to_sym
    end
  end

  resources :students
  resources :teachers

  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home about contact acknowledgements sign_up_selection].each do |page|
    get page, controller: "pages", action: page
  end
end
