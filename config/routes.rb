Rails.application.routes.draw do
  devise_for :users
  resources :projects
  resources :investigators
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'

  post 'register_project_investigators', action: :register_project_investigators, controller: 'projects'
end