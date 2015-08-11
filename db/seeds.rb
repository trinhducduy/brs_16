10.times do |n|
  name = Faker::Name.name
  email = "brs16#{n+1}@framgia.com"
  password = "12345678"
  User.create name:  name,
    email: email,
    password: password,
    password_confirmation: password
end

5.times do
  name = Faker::Name.title
  description = Faker::Lorem.paragraphs(1)
  Category.create! name: name, description: description
end

Category.all.each do |category|
  10.times do
    title = Faker::Name.title
    author = Faker::Name.name
    published_date = Faker::Date.between 10.days.ago, Date.today
    number_of_page = Faker::Number.between 40, 500
    description = Faker::Lorem.paragraphs 5
    category.books.create title: title, author: author, number_of_page: number_of_page,
      published_date: published_date, description: description
  end
end

Book.all.each do |book|
  5.times do
    content = Faker::Lorem.sentence 2
    rating = Faker::Number.between 1, 5
    user = User.offset(rand User.count).first
    book.reviews.create content: content, rating: rating, user_id: user.id
  end
end

Review.all.each do |review|
  5.times do
    content = Faker::Lorem.sentence 1
    user = User.offset(rand User.count).first
    review.comments.create content: content, user_id: user.id
  end
end

Book.all.each do |book|
  5.times do
    user = User.offset(rand User.count).first
    book.user_books.create status: UserBook.statuses[:read], favored: true
  end
end

Activity.all.each do |activity|
  3.times do |n|
    user = User.offset(rand User.count).first
    activity.activity_likes.create user_id: user.id
  end
end
