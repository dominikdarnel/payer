module Policies
  class Transaction
    def initialize(from_account, to_account, amount)
      @from_account = from_account
      @to_account = to_account
      @amount = amount
    end

    def accounts_on_same_currency?
      @from_account.currency == @to_account.currency
    end

    def from_account_has_funds?
      !@from_account.amount.zero?
    end

    def from_account_has_enough_funds?
      @from_account.amount > @amount
    end

    def accounts_have_different_owner?
      @from_account.user != @to_account.user
    end
  end
end
