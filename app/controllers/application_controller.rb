class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_search
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  def load_search
    @q = Book.ransack params[:q], auth_object: init_ransack_auth_object
  end

  def init_ransack_auth_object
    user_signed_in? && current_user.admin? ? :admin : nil
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit :name, :email,
      :password, :password_confirmation, :remember_me }
  end
end
