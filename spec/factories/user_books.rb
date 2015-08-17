FactoryGirl.define do
  factory :user_book do
    user
    book
  end

  factory :read_user_book, parent: :user_book do |f|
    f.status UserBook.statuses[:read]
  end

  factory :favored_user_book, parent: :user_book do |f|
    f.favored true
  end
end
