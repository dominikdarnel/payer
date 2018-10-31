require 'delegate'

module Presenters
  class Transaction < SimpleDelegator
    def my_accounts
      from_user.accounts
    end

    def other_users
      User.where.not(id: from_user.id)
    end

    def accounts_for_transaction(user, account_param)
      ::Account.all.select do |account|
        account.user == user &&
          account.currency == account_param.currency
      end
    end

    def accounts_for_transaction_json(user, account_param)
      accounts_for_transaction(user, account_param).map do |account|
        {
          text: account.name,
          id: account.id
        }
      end
    end

    def transaction_type(current_user)
      case current_user
      when from_user
        'Charge'
      when to_user
        'Credit'
      end
    end

    def displayed_amount
      case from_account.currency
      when Constants::CURRENCIES[:usd][:code]
        "#{amount} $"
      when Constants::CURRENCIES[:eur][:code]
        "#{amount} €"
      when Constants::CURRENCIES[:huf][:code]
        "#{amount} HUF"
      end
    end
  end
end
