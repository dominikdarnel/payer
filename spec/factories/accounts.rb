FactoryBot.define do
  factory :account do
    currency { Value::Currency.new.code }
    name { 'My USD account' }
    amount { 1000 }
    user { build(:user) }
  end
end
