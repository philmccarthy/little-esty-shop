FactoryBot.define do
  factory :admin do
    email { "admin@password.com" }
    password { "strongpassword" }
    password_confirmation { "strongpassword" }
  end
end
