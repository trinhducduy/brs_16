class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: [:update]

  layout false

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    @request.user = current_user
    if @request.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.json {render json: {status: "success",
          message: t("application.flash.request_sent"), data: @request}}
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.json {render json: {status: "failed",
          data: @request.errors.full_messages}}
      end
    end
  end

  def update
    unless @request.update_attributes status: :cancel
      flash[:danger] = t "application.flash.something_wrong"
    end
    respond_to do |format|
      format.html{redirect_to user_path(@request.user, type: Settings.users.requests)}
      format.js{render "requests/request"}
    end
  end

  private
  def request_params
    params.require(:request).permit :book_title, :author
  end

  def load_request
    @request = Request.find params[:id]
  end
end
