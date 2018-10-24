class Account < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :currency, presence: true, inclusion: { in: Value::Currency.codes }
end
