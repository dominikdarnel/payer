class Card < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :month, presence: true, inclusion: { in: Constants::VALID_MONTHS }
  validates :year, presence: true, inclusion: { in: Constants::VALID_YEARS }
  validates :number, presence: true, length: { is: 16 }
  validates :ccv, presence: true, length: { is: 3 }
  validates :amount, presence: true
  validates :bank, presence: true
  validates :currency, presence: true, inclusion: { in: Value::Currency.codes }
end
