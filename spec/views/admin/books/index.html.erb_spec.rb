require "rails_helper"
require "will_paginate/array"

describe "admin/books/index.html.erb" do
  subject {rendered}
  let(:sample_books) do [
    FactoryGirl.create(:book),
    FactoryGirl.create(:book),
    FactoryGirl.create(:book)
  ]
  end

  before do
    books = sample_books.paginate(per_page: 2)
    assign :books, books
    assign :test, books
    render
  end

  it "has a title" do
    is_expected.to have_selector "h1"
  end

  it "has add new book button" do
    is_expected.to have_selector "a[href='/admin/books/new']"
  end

  it "render correct partial" do
    is_expected.to render_template partial: "_book", count: 2
  end

  it "has correct pagination" do
    is_expected.to have_selector ".next_page[href='/admin?page=2']"
  end
end
