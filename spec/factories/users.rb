Factory.define :user do |user|
  user.name                   Faker::Name.unique.name
  user.email                  Faker::Email.unique.email
  user.password               '10203040'
  user.password_confirmation  '10203040'
end
