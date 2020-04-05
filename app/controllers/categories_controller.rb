class CategoriesController < ApplicationController
  before_action :find_category_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :destroy]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created successfully"
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Successfully updated"
      redirect_to @category
    else
      render :edit
    end
  end

  private
  def find_category_by_id
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    # for now no admin needed -> develop test from scratch
    return true

    if !logged_in? || !is_admin? # both variables available because of setting these in logged_in? or prior before actions
      flash[:danger] = "You need to be admin"
      redirect_to root_path
    end
  end
end
