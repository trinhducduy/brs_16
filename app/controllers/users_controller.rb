class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :load_user, only: [:edit, :show, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.pagination.page_size
  end

  def show
    case @type = params[:type] || Settings.users.timeline
    when Settings.users.reading_history
      list_reading_history
    when Settings.users.favorite_books
      list_favorite_books
    when Settings.users.requests
      list_user_requests
    when Settings.users.followers
      list_followers
    when Settings.users.following
      list_following
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
    @activities = @user.activities.includes(:liked_users).paginate page: params[:page],
      per_page: Settings.pagination.activity_log.page_size
    respond_to do |format|
      format.html {render "users/timeline"}
      format.js {render "activities/listing"}
    end
  end

  def list_favorite_books
    @books = Book.favored_by @user
    render "users/favorite_books"
  end

  def list_reading_history
    @books = Book.read_by @user
    render "users/reading_history"
  end

  def list_user_requests
    @requests = @user.requests.latest.paginate page: params[:page],
      per_page: Settings.pagination.page_size
    render "users/requests"
  end

  def list_followers
    @users = @user.followeds.paginate page: params[:page],
      per_page: Settings.pagination.page_size
    render "users/relationships"
  end

  def list_following
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.pagination.page_size
    render "users/relationships"
  end
end
