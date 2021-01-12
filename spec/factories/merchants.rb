FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    email { Faker::Internet.email }
    password { "strongpassword" }
    password_confirmation { "strongpassword" }
  end
end
