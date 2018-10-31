class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Presenters::Transaction.new(new_transaction)
    respond_to do |format|
      format.js
    end
  end

  def create
    @transaction_service = Services::TransactionCreator.new(transaction_params, current_user)

    respond_to do |format|
      if @transaction_service.save
        format.html { redirect_to transactions_path, flash: { success: 'Transaction was successfully created.' } }
        format.json { render :index, status: :created, location: @transaction }
      else
        format.html { redirect_to transactions_path, flash: { error: 'Transaction could not be made due to errors!' } }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def new_transaction
    Transaction.new(from_user: current_user)
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount,
      :to_user_id,
      :from_account_id,
      :to_account_id
    )
  end
end
