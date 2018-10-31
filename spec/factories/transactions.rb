FactoryBot.define do
  factory :transaction do
    amount { 100 }
    from_user { create(:user) }
    to_user { create(:user) }
    from_account { create(:account) }
    to_account { create(:account) }
  end
end
