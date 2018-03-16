class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  # MtM Association with Users: Likes
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  # MtM Association with Users: Votes
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user


  validates :rating, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 1}

  def vote_total
    votes.up.count - votes.down.count
  end

end
