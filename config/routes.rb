Rails.application.routes.draw do
  resources :users

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  post 'logout', to: 'sessions#destroy'

  get 'static/home'
  get 'static/deposit'
  get 'static/withdraw'
  get 'static/transfer'

  resources :accounts

  root "static#home"
end
