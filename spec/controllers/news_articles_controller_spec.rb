require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  describe 'new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'sets an instance variable with a new news article' do
      get :new
      expect(assigns(:news_article)).to be_a_new(NewsArticle)
    end
  end

  describe 'create' do
    context 'with valid parameters' do
      def valid_request
        post :create, params: {news_article: FactoryBot.attributes_for(:news_article)}
      end

      it 'create new news article in the db' do
        count_before = NewsArticle.count
        valid_request
        count_after = NewsArticle.count

        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the home page' do
        valid_request

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      def invalid_request
        post :create, params: {news_article: FactoryBot.attributes_for(:news_article, title: nil)}
      end

      it 'create new news article in the db' do
        count_before = NewsArticle.count
        invalid_request
        count_after = NewsArticle.count

        expect(count_after).to eq(count_before)
      end
    end

  end

  describe 'edit' do
    it 'renders the edit page' do
      @news_article = FactoryBot.create :news_article
      get :edit, params: { id: @news_article.id }

      expect(response).to render_template(:edit)
    end

    it 'sets an instance variable of the persisted news article' do
      @news_article = FactoryBot.create :news_article
      get :edit, params: { id: @news_article.id }

      expect(assigns(:news_article)).to eq(@news_article)
    end
  end

  describe 'update' do
    it 'updates a news article in the db' do
      @news_article = FactoryBot.create :news_article
      patch :update, params: {id: @news_article.id, news_article: {title: 'Something Unique'}}
      expect(assigns(:news_article).title).to eq('Something Unique')
    end

    it 'redirects to the show page of that news article' do
      @news_article = FactoryBot.create :news_article
      patch :update, params: {id: @news_article.id, news_article: {title: 'Something Unique'}}
      expect(response).to redirect_to(news_article_path(@news_article))
    end
  end
end
