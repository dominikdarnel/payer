FactoryBot.define do
  factory :card do
    bank { "MyString" }
    name { "MyString" }
    number { 1 }
    month { 1 }
    year { 1 }
    ccv { 1 }
  end
end
