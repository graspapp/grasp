Grasp::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, skip: :registrations
  devise_for :students, :teachers,
    controllers: { registrations: "registrations" }, skip: :sessions

  %w(Student Teacher).each do |t|
    authenticated :user, lambda { |u| u.type == t } do
      root to: "#{ t.pluralize.underscore }#home", as: "#{ t }_root".to_sym
    end
  end

  resources :students do
    member do
      post :add_course
      delete :leave_course
    end
  end

  resources :teachers

  resources :courses
  resources :units
  resources :concepts
  resources :concept_progresses
  resources :contacts, only: [:new, :create]

  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home about acknowledgements sign_up_selection].each do |page|
    get page, controller: "pages", action: page
  end

  get "contact", controller: "contacts", action: :new
end
