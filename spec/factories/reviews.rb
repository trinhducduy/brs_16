FactoryGirl.define do
  factory :review do
    user
    book
    content "Test content one"
  end

end
