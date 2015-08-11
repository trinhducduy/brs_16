class Admin::RequestsController < Admin::BaseController
  before_action :load_request, only: [:update, :destroy]

  def index
    @requests = Request.latest.paginate page: params[:page],
      per_page: Settings.pagination.page_size
    @status_options = Request.statuses.keys.select{|x| x != "cancel"}
  end

  def update
    if @request.update request_params
      flash[:success] = t "application.flash.request_updated"
    else
      flash[:danger] = t "application.flash.request_updated_failed"
    end

    redirect_to admin_requests_path
  end

  def destroy
    if @request.destroy
      flash[:success] = t "application.flash.request_deleted"
    else
      flash[:danger] = t "application.flash.request_deleted_failed",
        request: @request.name
    end

    respond_to do |format|
      format.html {redirect_to admin_requests_path}
      format.js {flash.discard}
    end
  end

  private
  def load_request
    @request = Request.find params[:id]
  end

  def request_params
    params.require(:request).permit :status
  end
end
