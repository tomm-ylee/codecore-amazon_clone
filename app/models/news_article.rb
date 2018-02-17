class NewsArticle < ApplicationRecord
  belongs_to :user, optional: true

  before_validation :titleize_title

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  validate :check_dates


  def publish
    update(published_at: Time.zone.now)
  end

  private

  def check_dates
    if published_at.present?
      if published_at < created_at
        errors.add(:published_at, "published date must after creation of news article")
      end
    end
  end

  def titleize_title
    self.title = self.title.titleize if self.title
  end

end
