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

    def my_accounts_for_select
      my_accounts.map do |account|
        [account.name, account.id]
      end
    end

    def cards_for_account_json(account)
      cards_for_account(account).map do |card|
        {
            text: Presenters::Card.new(card).number_display,
            id: card.id
        }
      end
    end
  end
end
