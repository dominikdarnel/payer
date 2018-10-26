Rails.application.routes.draw do
  root 'landing#index'
  resources :transactions
  resources :cards, only: %i[index new create destroy]
  devise_for :users
  resources :accounts, except: :show
  get 'accounts/add_funds' => 'accounts#add_funds'
  post 'accounts/add_funds' => 'accounts#add_funds'
  post 'accounts/cards_for_account' => 'ajax#cards_for_account'
end
