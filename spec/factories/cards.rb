FactoryBot.define do
  factory :card do
    bank { Faker::Bank.name }
    currency { Value::Currency.new.code }
    number { Faker::Bank.account_number(17) }
    month { 9 }
    year { 21 }
    ccv { 657 }
    amount { 3452 }
    user { create(:user) }

    trait :invalid do
      number { nil }
    end
  end
end
