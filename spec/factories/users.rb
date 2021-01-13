FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "strongpassword" }
    password_confirmation { "strongpassword" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { Faker::Ancient.titan }

  end
end
