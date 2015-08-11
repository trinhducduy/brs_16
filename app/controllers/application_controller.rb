class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_search

  private
  def load_search
    @q = Book.ransack params[:q], auth_object: init_ransack_auth_object
  end

  def init_ransack_auth_object
    user_signed_in? && current_user.admin? ? :admin : nil
  end
end
