class NewsArticlesController < ApplicationController
  def new
    @news_article = NewsArticle.new
  end

  def create
    @news_article = NewsArticle.create news_article_params
    redirect_to root_path
  end

  def edit
    @news_article = NewsArticle.find params[:id]
  end

  def update
    @news_article = NewsArticle.find params[:id]
    @news_article.update news_article_params
    redirect_to news_article_path(params[:id])
  end

  private

  def news_article_params
    params.require(:news_article).permit(:title, :description)
  end



end
