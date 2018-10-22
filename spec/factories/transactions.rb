FactoryBot.define do
  factory :transaction do
    amount { 1 }
    initiated_by { nil }
    from_account { nil }
    to_account { nil }
  end
end
