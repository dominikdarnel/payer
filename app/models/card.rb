class Card < ApplicationRecord
  belongs_to :user
  
  validates :user, presence: true
  validates :name, presence: true
  validates :month, presence: true, length: { is: 2 }
  validates :year, presence: true, length: { is: 2 }
  validates :number, presence: true, length: { is: 16 }
  validates :ccv, presence: true, length: { is: 3 }
  validates :amount, presence: true
  validates :bank, presence: true
  validates :currency, presence: true, inclusion: { in: Value::Currency.codes }
end
