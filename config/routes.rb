Grasp::Application.routes.draw do
  
  root to: "static_pages#home"

  get "/help",    to: "static_pages#help"
  get "/about",   to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
end
