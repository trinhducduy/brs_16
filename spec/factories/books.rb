FactoryGirl.define do
  factory :book do
    sequence(:title) {|n| "Book Title #{n}"}
    published_date "2015-03-20"
    author "Author"
    description "This is a sample book"
    number_of_page 20
    category
  end
end
