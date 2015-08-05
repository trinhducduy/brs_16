class RequestsController < ApplicationController
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
          message: t("application.flash.request_sent")}}
      end
    else
      respond_to do |format|
        format.html {render :new}
        format.json {render json: {status: "failed",
          data: @request.errors.full_messages}}
      end
    end
  end

  private
  def request_params
    params.require(:request).permit :book_title, :author
  end
end
