module Services
  class FundsCreator
    attr_reader :account

    def initialize(account, params)
      @account = account
      @card = Card.find(params[:card_id])
      @amount = params[:amount]
      @funding_policy = Policies::Funding.new(@account, @card, @amount)
    end

    def save
      add_funds!
      if account_and_card_is_valid?
        @card.save
        @account.save
      else
        false
      end
    end

    private

    def add_funds!
      if funding_is_valid?
        @card.decrement(:amount, @amount)
        @account.increment(:amount, @amount)
      else
        @account.errors.add(:funding, invalid_funding_msg)
        false
      end
    end

    def funding_is_valid?
      @funding_policy.card_has_funds? &&
        @funding_policy.card_has_same_currency_as_account? &&
        @funding_policy.card_has_enough_funds? &&
        @funding_policy.card_and_account_has_same_owner?
    end

    def account_and_card_is_valid?
      @account.valid? && @card.valid?
    end

    def invalid_funding_msg
      'is not successfull, contact your bank for further information.'
    end
  end
end
