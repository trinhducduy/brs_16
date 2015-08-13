class Admin::UsersController < Admin::BaseController

  def index
    @users = User.member.paginate page: params[:page],
      per_page: Settings.pagination.page_size
  end

  def destroy
    @user = User.find params[:id]
    unless @user.destroy
      flash[:danger] = t "application.flash.delete_user_failed"
    end
    respond_to do |format|
      format.html{redirect_to admin_users_path}
      format.js{}
    end
  end
end
