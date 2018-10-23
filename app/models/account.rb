class Account < ApplicationRecord
  belongs_to :user
  has_many :cards

  validates :user, presence: true
  validates :name, presence: true
  validates :currency, presence: true, inclusion: { in: Value::Currency.codes }
end
