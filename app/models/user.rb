class User < ApplicationRecord
  # Many Association with Products
  has_many :products, dependent: :destroy

  # Many Association with Reviews
  has_many :reviews, dependent: :nullify

  # Many Association with News Articles
  has_many :news_articles, dependent: :nullify

  # Many Association with Locations
  has_many :locations, dependent: :destroy
  
  # MtM Association with Products: Favourites
  has_many :favourites, dependent: :destroy
  has_many :favourite_products, through: :favourites, source: :product

  # MtM Association with Reviews: Likes
  has_many :likes, dependent: :destroy
  has_many :liked_review, through: :likes, source: :review

  # MtM Association with Reviews: Votes
  has_many :votes, dependent: :destroy
  has_many :voted_review, through: :votes, source: :review

  has_secure_password

  validates :first_name, :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  def full_name
  "#{first_name} #{last_name}".strip
  end

  def self.search(search_term)
    self.where('first_name LIKE ? OR last_name LIKE ? OR email like ?', "#{search_term}", "#{search_term}", "#{search_term}")
  end

end
