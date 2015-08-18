FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  factory :user do
    name "Tester"
    email
    password "12345678"
    password_confirmation "12345678"
  end
end
