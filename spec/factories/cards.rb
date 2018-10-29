FactoryBot.define do
  factory :card do
    bank { Faker::Bank.name }
    currency { Value::Currency.new.code }
    number { 1234123412341234 }
    month { 9 }
    year { 21 }
    ccv { 657 }
    amount { 3452 }
    user { create(:user) }

    trait :invalid do
      number { nil }
    end

    trait :eur_currency do
      currency { Constants::CURRENCIES[:eur][:code] }
    end

    trait :usd_currency do
      currency { Constants::CURRENCIES[:usd][:code] }
    end

    trait :huf_currency do
      currency { Constants::CURRENCIES[:huf][:code] }
    end

    trait :eur_amount do
      amount { 350 }
    end

    trait :usd_amount do
      amount { 220 }
    end

    trait :huf_amount do
      amount { 37_000 }
    end
  end
end
