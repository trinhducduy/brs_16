FactoryGirl.define do
  factory :user do
    name "Tester"
    sequence(:email) {|n| "test-#{n}@framgia.com"}
    password "12345678"
    password_confirmation "12345678"
  end

  factory :admin, parent: :user do
    sequence(:name) {|n| "Admin #{n}"}
    role User.roles[:admin]
  end
end
