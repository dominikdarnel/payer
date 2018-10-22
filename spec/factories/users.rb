FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { '10203040' }
    password_confirmation { '10203040' }
  end
end
