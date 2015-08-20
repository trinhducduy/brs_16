require "rails_helper"

describe "admin/books/edit.html.erb" do
  subject {rendered}
  let(:book) {FactoryGirl.create :book}

  before do
    assign :book, book
    render
  end

  it "has a title" do
    is_expected.to have_selector "h1"
  end

  it "render correct form" do
    is_expected.to have_selector "form[id='edit_book_#{book.id}'][method='post']"
  end
end
