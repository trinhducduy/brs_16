class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.latest.paginate page: params[:page],
      per_page: Settings.pagination.page_size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "application.flash.category_created"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:success] = t "application.flash.category_updated"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "application.flash.category_deleted"
    else
      flash[:danger] = t "application.flash.category_deleted_failed",
        category: @category.name
    end

    respond_to do |format|
      format.html {redirect_to admin_categories_path}
      format.js {flash.discard}
    end
  end

  private
  def load_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
