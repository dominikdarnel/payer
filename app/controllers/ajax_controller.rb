class AjaxController < ApplicationController
  def cards_for_account
    account = Account.find(params[:account_id])
    cards_for_account = Presenters::Funds.new(current_user).cards_for_account_json(account)
    render json: { result: cards_for_account }
  end
end
