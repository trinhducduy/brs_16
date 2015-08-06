class BooksController < ApplicationController
  def index
    @categories = Category.all.includes :books
  end
end
