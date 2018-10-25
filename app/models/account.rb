class Account < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, inclusion: { in: Value::Currency.codes }
end
