Rails.application.routes.draw do
  root 'accounts#index'
  devise_for :users
  resources :transactions, only: %i[index new create]
  resources :cards, only: %i[index new create destroy]
  resources :accounts, except: :show
  get 'accounts/add_funds' => 'accounts#add_funds'
  post 'accounts/add_funds' => 'accounts#add_funds'
  post 'accounts/cards_for_account' => 'ajax#cards_for_account'
  post 'transactions/accounts_for_transaction' => 'ajax#accounts_for_transaction'
end
