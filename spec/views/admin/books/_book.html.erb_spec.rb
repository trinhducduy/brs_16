require "rails_helper"
require "will_paginate/array"

describe "admin/books/_book.html.erb" do
  subject {rendered}
  let(:book) {FactoryGirl.create(:book)}

  before do
    render "admin/books/book", book: book
  end

  it "render correct book" do
    is_expected.to have_selector "tr[id='book_#{book.id}']"
    is_expected.to have_selector "a[href='/books/#{book.id}']",
      text: book.title
    is_expected.to include book.title
    is_expected.to include book.author
    is_expected.to include book.published_date
    is_expected.to include book.category.name
    is_expected.to include book.description.truncate(Settings.text.length)
    is_expected.to have_selector "a[href='/admin/books/#{book.id}/edit']",
      text: "Edit"
    is_expected.to have_selector "a[href='/admin/books/#{book.id}'][data-method='delete']",
      text: "Delete"
  end
end
