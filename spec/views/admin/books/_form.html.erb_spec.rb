require "rails_helper"

describe "admin/books/_form.html.erb" do
  subject {rendered}
  let(:book) {Book.new}

  before do
    assign :book, book
    render partial: "admin/books/form"
  end

  it "render form errors" do
    is_expected.to render_template partial: "_form_errors"
  end

  it "has correct form properties" do
    is_expected.to have_selector "form[action='/admin/books']" do |f|
      f.is_expected.to have_selector "input[type='submit']"
    end
  end

  it "has necessary form fields" do
    is_expected.to have_selector "input[type='text'][name='book[title]']"
    is_expected.to have_selector "input[type='text'][name='book[author]']"
    is_expected.to have_selector "input[type='text'][name='book[published_date]']"
    is_expected.to have_selector "input[type='number'][name='book[number_of_page]']"
    is_expected.to have_selector "textarea[name='book[description]']"
    is_expected.to have_selector "select[name='book[category_id]']"
    is_expected.to have_selector "input[type='file'][name='book[image]']"
  end
end
