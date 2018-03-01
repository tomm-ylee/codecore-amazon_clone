class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user


  validates :rating, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}

end
