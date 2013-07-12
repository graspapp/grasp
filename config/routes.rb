Grasp::Application.routes.draw do
  authenticated :teacher do
    root to: "teachers#home", as: :teacher_root
  end

  authenticated :student do
    root to: "students#home", as: :student_root
  end
    root to: "static_pages#home"
  
  devise_for :teachers, controllers: { sessions: 'sessions'}
  devise_for :students, controllers: { sessions: 'sessions'}
  resources :teachers, :students
  
  devise_scope :teacher do
    get "/teacher/sign_up" => "devise/registrations#new"
    get "/sign_in" => "devise/sessions#new"
    delete "/sign_out", to: "sessions#destroy"
  end

  devise_scope :student do
    get "/student/sign_up" => "devise/registrations#new"
    delete "/sign_out", to: "sessions#destroy"
  end
  

  get "/help",     to: "static_pages#help"
  get "/about",    to: "static_pages#about"
  get "/contact",  to: "static_pages#contact"
  get "/sign_up",  to: "static_pages#sign_up"
end
