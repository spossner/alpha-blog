class ArticlesController < ApplicationController
  before_action :find_article_by_id, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new  # create empty article to be able to render in partial
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Successfully saved"
      redirect_to @article
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Successfully updated"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Successfully deleted"
    end
    redirect_to articles_path
  end

  private
  def find_article_by_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
