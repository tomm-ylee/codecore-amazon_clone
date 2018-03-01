require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

  let(:user) { FactoryBot.create :user }

  describe 'new' do
    context 'no user is signed in' do
      it 'redirects to the sign in page' do
        get :new

        expect(response).to redirect_to new_session_path
      end
    end

    context 'user is signed in' do
      before do
        request.session[:user_id] = user.id
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'sets an instance variable with a new news article' do
        get :new
        expect(assigns(:news_article)).to be_a_new(NewsArticle)
      end
    end
  end

  describe 'create' do
    context 'with no user signed in' do
      it 'redirects to the sign in page' do
        post :create, params: { job_post: FactoryBot.attributes_for(:news_article) }

        expect(response).to redirect_to new_session_path
      end
    end

    context 'with user signed in' do
      before do
        request.session[:user_id] = user.id
      end

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

        it 'associates the news article with the signed in user' do
          valid_request

          expect(NewsArticle.last.user).to eq(user)
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
  end

  describe 'edit' do
    context 'user is not authenticated' do
      before do
        @news_article = FactoryBot.create :news_article
        get :edit, params: { id: @news_article.id }
      end
      it 'redirects to sign in page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'user is not authorized' do
      before do
        @news_article = FactoryBot.create :news_article
        request.session[:user_id] = user.id
        get :edit, params: { id: @news_article.id }
      end

      it 'flashes an alert' do
        expect(flash[:alert]).to be
      end

      it 'redirects to home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user is authenticated and authorized' do
      before do
        @news_article = FactoryBot.create :news_article
        request.session[:user_id] = @news_article.user.id
        get :edit, params: { id: @news_article.id }
      end

      it 'renders the edit page' do
        expect(response).to render_template(:edit)
      end

      it 'sets an instance variable of the persisted news article' do
        expect(assigns(:news_article)).to eq(@news_article)
      end
    end
  end

  describe 'update' do
    context 'user is not authenticated' do
      before do
        @news_article = FactoryBot.create :news_article
        patch :update, params: {
          id: @news_article.id,
          news_article: {title: 'Something Unique'}
        }
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to new_session_path
      end
    end

    context 'user is not authorized' do
      before do
        @news_article = FactoryBot.create :news_article
        request.session[:user_id] = user.id
        patch :update, params: {
          id: @news_article.id,
          news_article: {title: 'Something Unique'}
        }
      end

      it 'flashes an alert' do
        expect(flash[:alert]).to be
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user is authenticated and authorized' do

      context 'parameters are invalid' do
        before do
          @news_article = FactoryBot.create :news_article
          request.session[:user_id] = @news_article.user.id
          patch :update, params: {
            id: @news_article.id,
            news_article: {title: ''}
          }
        end
        it 'renders the edit page' do
          expect(response).to redirect_to render_template(:edit)
        end
      end

      context 'parameters are valid' do
        before do
          @news_article = FactoryBot.create :news_article
          request.session[:user_id] = @news_article.user.id
          patch :update, params: {
            id: @news_article.id,
            news_article: {title: 'Something Unique'}
          }
        end
        it 'updates a news article in the db' do
          expect(NewsArticle.order(updated_at: :desc).first.title).to eq('Something Unique')
        end
        # NewsArticle.order(updated_at: :DESC).first

        it 'redirects to the show page of that news article' do
          expect(response).to redirect_to(news_article_path(@news_article))
        end
      end
    end
  end

  describe 'destroy' do
    it 'destroys the entry from the db' do
      news_article = FactoryBot.create :news_article
      count_before = NewsArticle.count
      delete :destroy, params: { id: news_article.id }
      count_after = NewsArticle.count

      expect(count_after).to eq(count_before -1)
    end

    it 'redirects to the index page' do
      news_article = FactoryBot.create :news_article
      delete :destroy, params: { id: news_article.id }

      expect(response).to redirect_to(news_articles_path)
    end

    it 'sends a flash notice after deletion' do
      news_article = FactoryBot.create :news_article
      delete :destroy, params: { id: news_article.id }

      expect(flash[:notice]).to be
    end

  end

  describe 'show' do
    it 'renders the show page of a news article' do
      news_article = FactoryBot.create :news_article
      get :show, params: { id: news_article.id }

      expect(response).to render_template(:show)
    end
    it 'renders the show page of a news article with the correct id' do
      news_article = FactoryBot.create :news_article
      get :show, params: { id: news_article.id }

      expect(assigns(:news_article)).to eq(news_article)
    end
  end

  describe 'index' do
    it 'renders the index page of all news article' do
      get :index

      expect(response).to render_template(:index)
    end
  end
end
