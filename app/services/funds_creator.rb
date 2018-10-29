module Services
  class FundsCreator
    def initialize(params)
      @account = Account.find(params[:account_id])
      @card = Card.find(params[:card_id])
      @amount = params[:amount].to_i
      @funding_policy = Policies::Funding.new(@account, @card, @amount)
    end

    def save
      add_funds!
      if account_and_card_is_valid?
        @card.save
        @account.save
        Rails.logger.info '[FundsCreator] Funding is successfull.'
        true
      else
        Rails.logger.error "[FundsCreator] Funding was not successful: #{@account.errors.full_messages} #{@card.errors.full_messages}."
        false
      end
    end

    private

    def add_funds!
      if funding_is_valid?
        @card.decrement(:amount, @amount)
        @account.increment(:amount, @amount)
        Rails.logger.info '[FundsCreator] Funds have been successfully taken from Card.'
      else
        @account.errors.add(:funding, invalid_funding_msg)
        Rails.logger.error "[FundsCreator] Funds could not be taken from Card due to errors: #{@account.errors.full_messages}."
      end
    end

    def funding_is_valid?
      @funding_policy.card_has_funds? &&
        @funding_policy.card_has_same_currency_as_account? &&
        @funding_policy.card_has_enough_funds? &&
        @funding_policy.card_and_account_has_same_owner?
    end

    def account_and_card_is_valid?
      @account.errors.empty? && @account.valid? && @card.valid?
    end

    def invalid_funding_msg
      'is not successfull, contact your bank for further information.'
    end
  end
end
