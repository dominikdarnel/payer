FactoryBot.define do
  factory :account do
    currency { "MyString" }
    amount { 1 }
    user { nil }
  end
end
