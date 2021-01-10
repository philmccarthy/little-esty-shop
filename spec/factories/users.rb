FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "strongpassword" }
    password_confirmation { "strongpassword" }
    role { 0 }
  end
end
