FactoryBot.define do
  factory :card do
    bank { Faker::Bank.name }
    name { 'My Little Bank Card' }
    currency { Value::Currency.new.code }
    number { Faker::Bank.account_number(17) }
    month { 9 }
    year { 21 }
    ccv { 657 }
  end
end
