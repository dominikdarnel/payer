FactoryBot.define do
  factory :account do
    currency { Value::Currency.new.code }
    name { 'My USD account' }
    amount { 1000 }
    user { create(:user) }

    trait :invalid do
      currency { nil }
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
