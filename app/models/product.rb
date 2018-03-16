class Product < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  # MtM Association with Users: Favourites
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  # MtM Association with Tags: Taggings
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # FAQs
  has_many :faqs, dependent: :destroy
  accepts_nested_attributes_for :faqs, reject_if: :all_blank, allow_destroy: true

  # Validations
  after_initialize :default_zero_hit
  before_validation :set_default_price
  before_validation :set_default_sale_price

  validates :title,
    presence: true,
    uniqueness: {case_sensitive: false},
    format: {without: /Apple|Microsoft|Sony/i}

  validates :price, numericality: {greater_than: 0, less_than: 1000}
  validates :description, presence: true, length: {minimum: 10}
  validates :sale_price, numericality: {less_than_or_equal_to: :price}

  before_save :capitalize_title
  # before_destroy :notify_delete


  # Helpful Methods
  def self.search(search_word)
    Product.where('title ILIKE ? OR description ILIKE ?', "%#{search_word}%", "%#{search_word}%")
  end

  def self.search_(search_word)
    Product.where('title ILIKE ?', "%#{search_word}%") + Product.where('description ILIKE ?', "%#{search_word}%")
  end

  def increment
    self.hit_count += 1
  end

  def self.filter(search_term, sort_by_column, current_page, per_page_count)
    Product
      .where( 'title ILIKE ? or description ILIKE ?', "%#{search_term}%", "%#{search_term}%" )
      .order( "#{sort_by_column}": 'ASC' )
      .limit( per_page_count )
      .offset( ( current_page - 1 ) * per_page_count )
  end

  include FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  mount_uploader :image, ImageUploader

  private

  def set_default_price
    self.price ||= 1
  end

  def capitalize_title
    self.title.capitalize!
  end

  def set_default_sale_price
    self.sale_price ||= self.price
    self.sale_price = self.price if self.sale_price > self.price
  end

  def default_zero_hit
    self.hit_count = 0
  end

  def notify_delete
    puts 'Product is about to be deleted'
  end

end


# Product.where('price > 20 and price < 70').order(title: "ASC").limit(10)
