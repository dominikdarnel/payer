module Services
  class TransactionCreator
    def initialize(params, current_user)
      @current_user = current_user
      @transaction = Transaction.new
      @amount = params[:amount]
      @from_account = Account.find(params[:from_account_id])
      @to_account = Account.find(params[:to_account_id])
      @to_user = User.find(params[:to_user_id])
      @transaction_policy = Policies::Transaction.new(@from_account, @to_account, @amount)
    end

    def save
      if transaction_is_valid?
        balance_accounts!
        create_transaction!
        @transaction.save
        @from_account.save
        @to_account.save
        Rails.logger.info '[TransactionCreator] Transaction is successfull.'
        true
      else
        Rails.logger.error "[TransactionCreator] Transaction was not successful: #{@transaction.errors.full_messages} #{@transaction.errors.full_messages}."
        false
      end
    end

    private

    def create_transaction!
      @transaction.tap do |transaction|
        transaction.amount = @amount
        transaction.from_account = @from_account
        transaction.to_account = @to_account
        transaction.from_user = @current_user
        transaction.to_user = @to_user
      end
    end

    def balance_accounts!
      @from_account.decrement(:amount, @amount)
      @to_account.increment(:amount, @amount)
    end

    def transaction_is_valid?
      @transaction_policy.accounts_on_same_currency? &&
        @transaction_policy.from_account_has_funds? &&
        @transaction_policy.from_account_has_enough_funds? &&
        @transaction_policy.accounts_have_different_owner?
    end
  end
end
