class ArticlesController < ApplicationController
  before_action :find_article_by_id, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]  # better to whitelist non public actions
  before_action :require_same_user_or_admin, only: [:edit, :update, :destroy]

  def show
  end

  def index
      @articles = Article.paginate(page: params[:page])
  end

  def new
    @article = Article.new  # create empty article to be able to render in partial
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Successfully saved"
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Successfully updated"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:danger] = "Successfully deleted"
    end
    redirect_to articles_path
  end

  private
  def find_article_by_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user_or_admin
    if current_user != @article.user && !is_admin? # both variables set by logged_in? or before_action executed prior to this action
      flash[:danger] = "You can only maintain your own articles"
      redirect_to root_path
    end
  end
end
