Rails.application.routes.draw do
  root to: 'landing#index'
  resources :transactions
  resources :accounts, except: :show
  resources :cards, only: %i[index new create destroy]
  devise_for :users
end
