FactoryBot.define do
  factory :admin do
    email { 'admin@gmail.com' }
    password { "strongpassword" }
    password_confirmation { "strongpassword" }
  end
end
