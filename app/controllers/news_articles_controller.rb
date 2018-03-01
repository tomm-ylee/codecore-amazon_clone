class NewsArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :find_news_article, only: [:edit, :update, :show, :destroy]
  before_action :authorize_user!, only: [:edit, :update]


  def new
    @news_article = NewsArticle.new
  end

  def create
    puts news_article_params
    @news_article = NewsArticle.create news_article_params
    @news_article.user = current_user
    if @news_article.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @news_article.update news_article_params
      redirect_to news_article_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @news_article.destroy

    flash[:notice] = "Yup, you deleted"
    redirect_to news_articles_path
  end

  def show
  end

  def index
  end

  private

  def find_news_article
    @news_article = NewsArticle.find params[:id]
  end

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end

  def authorize_user!
    unless can?(:manage, @news_article)
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end


end
