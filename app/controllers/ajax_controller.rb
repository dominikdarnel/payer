class AjaxController < ApplicationController
  def cards_for_account
    account = Account.find(params[:account_id])
    cards_for_account = Presenters::Funds.new(current_user).cards_for_account_json(account)
    render json: { result: cards_for_account }
  end

  def accounts_for_transaction
    account = Account.find(params[:account_id])
    user = User.find(params[:user_id])
    new_transaction = Transaction.new(from_user: current_user)
    accounts_for_transaction = Presenters::Transaction.new(new_transaction)
                                               .accounts_for_transaction_json(user, account)
    render json: { result: accounts_for_transaction }
  end
end
