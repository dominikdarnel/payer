class Transaction < ApplicationRecord
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'
  belongs_to :from_account, class_name: 'Account', foreign_key: 'from_account_id'
  belongs_to :to_account, class_name: 'Account', foreign_key: 'to_account_id'
end
