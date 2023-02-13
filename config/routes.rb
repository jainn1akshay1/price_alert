Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create]
  get "users/:id", to: "users#show"
  post "triggers/create", to: "triggers#create"
  delete "triggers/delete", to: "triggers#delete"

  post '/auth/login', to: 'authentication#login'
end
