Grasp::Application.routes.draw do
  get "home", to: redirect("/")

  root to: "pages#home"

  %w[home about contact acknowledgements].each do |page|
    get page, controller: "pages", action: page
  end
end
