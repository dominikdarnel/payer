class AccountsController < ApplicationController
  before_action :set_account, only: [:update, :destroy]

  def index
    @accounts = Account.all.map do |account|
      Presenters::Account.new(account)
    end
  end

  def new
    @account = Presenters::Account.new(Account.new)
    respond_to do |format|
      format.js
    end
  end

  def edit
    @account = Presenters::Account.new(Account.find(params[:id]))
    respond_to do |format|
      format.js
    end
  end

  def create
    @account_service = Services::AccountModifier.new(Account.new, account_params, current_user)
    @account = @account_service.account
    respond_to do |format|
      if @account_service.save
        format.html { redirect_to accounts_path, flash: { success: 'Account was successfully created!' } }
        format.json { render :index, status: :created, location: @account }
      else
        format.html { redirect_to accounts_path, flash: { error: 'Account could not be created due to errors!' } }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @account_service = Services::AccountModifier.new(@account, account_params, current_user)
    @account = @account_service.account
    respond_to do |format|
      if @account_service.save
        format.html { redirect_to accounts_path, flash: { success: 'Account was successfully updated!' } }
        format.json { render :index, status: :ok, location: @account }
      else
        format.html { edirect_to accounts_path, flash: { error: 'Account could not be updated due to errors!' } }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, flash: { success: 'Account was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :currency, :amount, :user_id)
  end
end
