class UserBooksController < ApplicationController
  before_action :load_user_book, only: :create

  respond_to :json

  def create
    case params[:action_type]
    when Settings.user_books.unread
      @user_book.status = UserBook.statuses[:unread]
    when Settings.user_books.read
      @user_book.status = UserBook.statuses[:read]
    when Settings.user_books.reading
      @user_book.status = UserBook.statuses[:reading]
    when Settings.user_books.favored
      @user_book.favored = true
    when Settings.user_books.unfavored
      @user_book.favored = false
    end

    if @user_book.save
      render json: {status: "success", data: @user_book}
    else
      render json: {status: "failed",
        message: t("application.flash.something_wrong")}
    end
  end

  private
  def load_user_book
    @book = Book.find params[:book_id]
    @user_book = UserBook.find_or_initialize_by user_id: current_user.id,
      book_id: @book.id
  end
end
