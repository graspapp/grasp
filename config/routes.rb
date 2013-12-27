Grasp::Application.routes.draw do
  devise_for :users, skip: :registrations
  devise_for :students, :teachers, 
    controllers: { registrations: "registrations" }, skip: :sessions

  %w(Student Teacher).each do |t|
    authenticated :user, lambda { |u| u.type == t } do
      root to: "#{ t.pluralize.underscore }#home", as: "#{ t }_root".to_sym
    end
  end

  resources :students
  resources :teachers

  resources :courses

  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home about contact acknowledgements sign_up_selection].each do |page|
    get page, controller: "pages", action: page
  end
end
