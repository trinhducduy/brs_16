class BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    params[:type] == Settings.books.search ? search_books : list_books
  end

  def show
    if current_user
      @user_book = UserBook.find_or_initialize_by user_id: current_user.id,
        book_id: @book.id
    end
    @reviews = @book.reviews.paginate page: params[:page],
      per_page: Settings.pagination.page_size
  end

  private
  def load_book
    @book = Book.find params[:id]
  end

  def list_books
    @q.build_condition if @q.conditions.empty?
    @categories = Category.all.includes :books
    render "books/index"
  end

  def search_books
    @books = @q.result distinct: true
    render "books/search"
  end
end
