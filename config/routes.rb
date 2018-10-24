Rails.application.routes.draw do
  root to: "landing#index"
  resources :transactions
  resources :accounts, except: :show
  resources :cards
  devise_for :users
end
