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
  end
end
