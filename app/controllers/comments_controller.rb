class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    load_review
    @comments = @review.comments.latest.paginate page: params[:page],
      per_page: Settings.pagination.comment_size
    respond_to do |format|
      format.html{redirect_to @review.book}
      format.js
    end
  end

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = t "application.flash.create_comment_success"
    else
      flash[:danger] = t "application.flash.create_comment_failed"
    end
    @review = @comment.review
    respond_to do |format|
      format.html{redirect_to @review.book}
      format.js {}
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.destroy
      flash[:success] = t "application.flash.delete_comment_success"
    else
      flash[:danger] = t "application.flash.delete_comment_failed"
    end
    respond_to do |format|
      format.html{redirect_to comment.review.book}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :review_id
  end

  def load_review
    @review = Review.find params[:review_id]
  end
end
