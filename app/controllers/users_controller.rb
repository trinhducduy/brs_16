class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:edit, :show, :update]

  def show
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
end
