class Transaction < ApplicationRecord
  belongs_to :initiated_by, class_name: 'User'
  belongs_to :from_account, class_name: 'Account', foreign_key: 'from_account_id'
  belongs_to :to_account, class_name: 'Account', foreign_key: 'to_account_id'
end
