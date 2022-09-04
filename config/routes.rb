Rails.application.routes.draw do
  get 'static/home'
  get 'static/deposit'
  get 'static/withdraw'
  get 'static/transfer'
  resources :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "accounts#index"
end
