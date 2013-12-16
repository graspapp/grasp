Grasp::Application.routes.draw do
  authenticated :teacher do
    root to: "teachers#home", as: :teacher_root
  end

  authenticated :student do
    root to: "students#home", as: :student_root
  end
    root to: "static_pages#home"
  
  devise_for :teachers, controllers: { sessions: 'sessions', 
    passwords: "passwords"}
  devise_for :students, controllers: { sessions: 'sessions', 
    passwords: "passwords"}

  resources :teachers, :students
  resources :courses, only: [:create, :destroy]
  resources :units
  resources :concepts, only: [:create, :destroy]

  resources :concepts do
    get 'level_up', :on => :member  
  end  

  
  devise_scope :teacher do
    get "/teacher/sign_up" => "devise/registrations#new"
    get "/sign_in" => "devise/sessions#new"
    get "/password" => "passwords#new"
    post "/password" => "passwords#create"
    delete "/sign_out", to: "sessions#destroy"
  end

  devise_scope :student do
    get "/student/sign_up" => "devise/registrations#new"
    delete "/sign_out", to: "sessions#destroy"
  end
  
  get "/help",             to: "static_pages#help"
  get "/about",            to: "static_pages#about"
  get "/contact",          to: "static_pages#contact"
  get "/acknowledgements", to: "static_pages#acknowledgements"
  get "/sign_up",          to: "static_pages#sign_up"

  post 'students/add_course',     to: 'students#add_course'
  post 'teachers/add_unit',       to: 'teachers#add_unit'
  post 'units/add_concept',       to: 'units#add_concept'
  post 'concepts/modify_concept', to: 'concepts#modify_concept'
end
