FactoryGirl.define do
  factory :comment do
    user
    review
    content "comment content"
  end

end
