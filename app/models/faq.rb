class Faq < ApplicationRecord
  belongs_to :product

  validates :question, presence: true
  validates :answer, presence: true
end
