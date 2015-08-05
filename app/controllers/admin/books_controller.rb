class Admin::BooksController < Admin::BaseController
  def new
    @book = Book.new
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

  private
  def book_params
    params.require(:book).permit :title, :author, :published_date,
      :number_of_page, :description, :image, :category_id
  end
end
