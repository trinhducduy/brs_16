FactoryGirl.define do
  factory :user do
    name "Tester"
    sequence(:email) {|n| "test-#{n}@framgia.com"}
    password "12345678"
    password_confirmation "12345678"
  end
end
