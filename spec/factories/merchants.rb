FactoryBot.define do
  factory :merchant do
    user_name { Faker::Company.name }
  end
end
