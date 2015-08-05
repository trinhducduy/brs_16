class Admin::BaseController < ApplicationController
  private
  def authenticate_admin!
    unless current_user.admin?
      flash[:danger] = "application.flash.permission_denied"
      redirect_to root_path
    end
  end
end
