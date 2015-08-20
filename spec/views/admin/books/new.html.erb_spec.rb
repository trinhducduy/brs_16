require "rails_helper"

describe "admin/books/new.html.erb" do
  subject {rendered}
  let(:book) {Book.new}

  before do
    assign :book, book
    render
  end

  it "has a title" do
    is_expected.to have_selector "h1"
  end

  it "render correct form" do
    is_expected.to have_selector "form[id='new_book'][method='post']"
  end
end
