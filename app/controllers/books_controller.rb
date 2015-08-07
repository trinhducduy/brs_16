class BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    @categories = Category.all.includes :books
  end

  def show
  end

  private
  def load_book
    @book = Book.find params[:id]
  end
end
