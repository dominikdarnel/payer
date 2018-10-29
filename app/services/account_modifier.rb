module Services
  class AccountModifier
    attr_reader :account

    def initialize(account, params, current_user)
      @account = account
      @params = params
      @current_user = current_user
    end

    def save
      modify_account!
      if account_is_valid?
        @account.save
        Rails.logger.info '[AccountCreator] Account is successfully saved.'
        true
      else
        Rails.logger.error "[AccountCreator] Account could not be saved: #{@account.errors.full_messages}."
        false
      end
    end

    private

    def modify_account!
      if account_exists?
        update_account
      else
        create_account
      end
    end

    def create_account
      @account.tap do |account|
        account.name = @params[:name]
        account.currency = @params[:currency]
        account.user_id = @current_user.id
        account.amount = 0
      end
    end

    def update_account
      @account.tap do |account|
        account.name = @params[:name]
      end
    end

    def account_is_valid?
      @account.valid?
    end

    def account_exists?
      @account.persisted?
    end
  end
end
