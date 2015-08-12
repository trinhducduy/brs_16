class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:edit, :show, :update]

  def show
    case @type = params[:type] || Settings.users.timeline
    when Settings.users.reading_history
      list_reading_history
    when Settings.users.favorite_books
      list_favorite_books
    when Settings.users.requests
      list_user_requests
    else
      timeline
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :avatar
  end

  def timeline
    @activities = current_user.activities.includes(:liked_users).paginate page: params[:page],
      per_page: Settings.pagination.activity_log.page_size
    respond_to do |format|
      format.html {render "users/timeline"}
      format.js {render "activities/listing"}
    end
  end

  def list_favorite_books
    @books = Book.favored_by current_user
    render "users/favorite_books"
  end

  def list_reading_history
    @books = Book.read_by current_user
    render "users/reading_history"
  end

  def list_user_requests
    @requests = @user.requests.latest.paginate page: params[:page],
      per_page: Settings.pagination.page_size
    render "users/requests"
  end
end
