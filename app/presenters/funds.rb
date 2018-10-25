module Presenters
  class Funds
    def initialize(current_user)
      @current_user = current_user
    end

    def my_accounts
      @current_user.accounts
    end

    def cards_for_account(account)
      @current_user.cards.select do |card|
        account.currency == card.currency
      end
    end
  end
end
