class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_book, only: [:new, :create, :edit, :update]
  before_action :load_review, except: [:new, :create]

  layout false

  def new
    @review = @book.reviews.build
    render "reviews/form"
  end

  def edit
    render "reviews/form"
  end

  def create
    @review = @book.reviews.build review_params
    @review.user = current_user
    if @review.save
      respond_to do |format|
        format.html {redirect_to @book}
        format.json {render json: {status: "success", data: {review: @review,
          rating: @review.book.average_rating},
          message: t("application.flash.write_review_success")}}
      end
    else
      respond_to do |format|
        format.html {redirect_to @book}
        format.json {render json: {status: "failed",
          data: @review.errors.full_messages}}
      end
    end
  end

  def update
    if @review.update review_params
      respond_to do |format|
        format.html {redirect_to @book}
        format.json {render json: {status: "success", data: {rating: @review.book.average_rating},
          message: t("application.flash.edit_review_success")}}
      end
    else
      respond_to do |format|
        format.html {redirect_to @book}
        format.json {render json: {status: "failed",
          data: @review.errors.full_messages}}
      end
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "application.flash.delete_comment_success"
    else
      flash[:danger] = t "application.flash.delete_review_failed"
    end
    respond_to do |format|
      format.html{redirect_to @review.book}
      format.js
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :rating
  end

  def load_book
    @book = Book.find params[:book_id]
  end

  def load_review
    @review = Review.find params[:id]
  end
end
