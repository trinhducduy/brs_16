class Admin::BooksController < Admin::BaseController
  before_action :load_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.all.paginate page: params[:page],
     per_page: Settings.pagination.page_size
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "application.flash.create_book_success"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @book.update book_params
      flash[:success] = t "application.flash.update_book_success"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "application.flash.delete_book_success"
    else
      flash[:danger] = t "application.flash.delete_book_failed"
    end
    respond_to do |format|
      format.html{redirect_to admin_books_path}
      format.js
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :published_date,
      :number_of_page, :description, :image, :category_id
  end

  def load_book
    @book = Book.find params[:id]
  end
end
