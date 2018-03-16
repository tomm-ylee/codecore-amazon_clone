class Tag < ApplicationRecord
  # MtM Association with Products: Taggings
  has_many :taggings, dependent: :destroy
  has_many :products, through: :taggings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
