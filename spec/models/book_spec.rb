require "rails_helper"

describe Book do
  subject(:book) {FactoryGirl.create :book}

  let(:user) {FactoryGirl.create :user}
  let(:category) {FactoryGirl.create :category}

  describe "association" do
    it {expect have_many :reviews}
    it {expect have_many :user_books}
    context "should return correct category" do
      before {book.category = category}
      it {expect(book.category).to eq category}
    end
  end

  context "is invalid without a title" do
    before {book.title = nil}
    it {expect(book.error_on(:title).size).to eq 1}
  end

  context "is invalid without a published_date" do
    before {book.published_date = nil}
    it {expect(book.error_on(:published_date).size).to eq 1}
  end

  context "is invalid without an author" do
    before {book.author = nil}
    it {expect(book.error_on(:author).size).to eq 1}
  end

  context "is invalid without a category" do
    before {book.category = nil}
    it {expect(book.error_on(:category).size).to eq 1}
  end

  context "is invalid without a number of page" do
    before {book.number_of_page = nil}
    it {expect(book.error_on(:number_of_page).size).to eq 2}
  end

  context "is invalid with an incorrect number of page type" do
    before {book.number_of_page = "string"}
    it {expect(book.error_on(:number_of_page).size).to eq 1}
  end

  context "is invalid with a future date" do
    before {book.published_date = (Date.today + 3).to_s}
    it {expect(book.error_on(:published_date).size).to eq 1}
  end

  context "should return books read by a user" do
    before {FactoryGirl.create :read_user_book, user: user,
      book: book}
    it {expect(Book.read_by user).to include book}
  end

  context "should return books favored by a user" do
    before {FactoryGirl.create :favored_user_book, user: user,
      book: book}
    it {expect(Book.favored_by user).to include book}
  end
end
