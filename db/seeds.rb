require 'factory_bot_rails'
require 'faker'

User.create(
  name: 'Dominik Darnel',
  email: 'dominik@example.com',
  password: '10203040',
  password_confirmation: '10203040'
)

User.create(
  name: 'Sipos Marianna',
  email: 'sipos@example.com',
  password: '10203040',
  password_confirmation: '10203040'
)

10.times do
  FactoryBot.create(
    :user,
    email: Faker::Internet.safe_email,
    name: Faker::Name.name
  )
end

User.all.each do |user|
  FactoryBot.create(
    :account,
    :eur_currency,
    :eur_amount,
    name: 'My Ero Account',
    user: user
  )
  FactoryBot.create(
    :account,
    :usd_currency,
    :usd_amount,
    name: 'My USD Savings',
    user: user
  )
  FactoryBot.create(
    :account,
    :huf_currency,
    :huf_amount,
    name: 'My Forint Checking',
    user: user
  )
end

User.all.each do |user|
  FactoryBot.create(
    :card,
    :eur_currency,
    :eur_amount,
    bank: Faker::Bank.name,
    number: Faker::Number.number(16),
    user: user
  )
  FactoryBot.create(
    :card,
    :usd_currency,
    :usd_amount,
    bank: Faker::Bank.name,
    number: Faker::Number.number(16),
    user: user
  )
  FactoryBot.create(
    :card,
    :huf_currency,
    :huf_amount,
    bank: Faker::Bank.name,
    number: Faker::Number.number(16),
    user: user
  )
end
