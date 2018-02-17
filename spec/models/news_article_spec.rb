require 'rails_helper'

RSpec.describe NewsArticle, type: :model do
  # def news_article
  #   NewsArticle.new()
  # end

  def test_user
    @user ||= User.new(first_name: :Tommy, last_name: :Lee, email: 'tommylee@email.com')
  end

  def test_article
    @news_article ||= NewsArticle.new(
      title: 'people\'s corner',
      description: 'I feeling really strongly that...',
      user: test_user
    )
  end

  describe 'validations' do
    it 'requires a title' do
      na = test_article
      na.title = nil
      na.valid?

      expect(na.errors.messages).to have_key(:title)
    end


    it 'requires a unique title' do
      existing_na = test_article
      existing_na.save

      new_na = test_article
      new_na.valid?

      expect(new_na.errors.messages).to have_key(:title)
    end

    it 'requires a description' do
      na = test_article
      na.description = nil
      na.valid?

      expect(na.errors.messages).to have_key(:description)
    end

    it 'requires a later published date' do
      na = test_article
      na.save
      na.published_at = na.created_at
      na.valid?

      expect(na).to be_invalid
    end

    it 'requires a user' do
      na = test_article
      na.user = nil
      na.valid?

      expect(na.errors.messages).to have_key(:user)
    end
  end

  describe '#titleize_title' do
    it 'titleizes the title' do
      na = test_article
      na.title = "under the sea"
      na.save

      expect(na.title).to eq("Under The Sea")
    end
  end

  describe '#publish' do
    it 'publishes the article' do
      na = test_article
      na.save
      na.publish
      expect(na.published_at.to_i).to eq(Time.zone.now.to_i)
    end
  end

end
