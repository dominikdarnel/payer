Rails.application.routes.draw do
  resources :transactions
  resources :accounts
  resources :cards
  devise_for :users
  root to: "home#home"
end
