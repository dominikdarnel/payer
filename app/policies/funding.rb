module Policies
  class Funding
    def initialize(account, card, amount)
      @account = account
      @card = card
      @amount = amount
    end

    def card_has_same_currency_as_account?
      @account.currency == @card.currency
    end

    def card_has_funds?
      !@card.amount.zero?
    end

    def card_has_enough_funds?
      @card.amount > @amount
    end

    def card_and_account_has_same_owner?
      @account.user == @card.user
    end
  end
end
