Rails.application.routes.draw do
  devise_for :users, controllers: {
                     sessions: "users/sessions",
                     registrations: "users/registrations",
                   }

  devise_scope :user do
    get 'users' => 'users/registrations#index'
  end
  resources :projects
  resources :investigators
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'

  get 'get_project_investigators', action: :get_project_investigators, controller: 'projects'
end