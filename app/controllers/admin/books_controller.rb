class Admin::BooksController < Admin::BaseController
  before_action :load_book, only: [:edit, :update, :destroy]

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
    redirect_to :back
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
