class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: { scope: :review_id }

  validates :choice, inclusion: { in: [true, false] }

  def self.up
    where(choice: true)
  end

  def self.down
    where(choice: false)
  end
end
