Grasp::Application.routes.draw do
  
  devise_for :users
  root to: "static_pages#home"

  get "/help",    to: "static_pages#help"
  get "/about",   to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/sign_up", to: "static_pages#sign_up"
end
