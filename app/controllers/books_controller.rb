class BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    @categories = Category.all.includes :books
  end

  def show
    if current_user
      @user_book = UserBook.find_or_initialize_by user_id: current_user.id,
        book_id: @book.id
    end
  end

  private
  def load_book
    @book = Book.find params[:id]
  end
end
