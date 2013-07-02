Grasp::Application.routes.draw do
  
  devise_for :users, :controller => { :registrations => "users/registrations" } 
  devise_scope :users do
    get '/student/sign_up', :to => 'devise/registrations#new'
    get '/teacher/sign_up', :to => 'devise/registrations#new'
    get '/sign_in',         :to => 'devise/sessions#new' 
  end
  
  resources :users

  root to: "static_pages#home"

  get "/help",    to: "static_pages#help"
  get "/about",   to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/sign_up", to: "static_pages#sign_up"
end
