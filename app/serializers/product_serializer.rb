class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :created_at, :updated_at

  belongs_to :user, key: :seller
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :full_name
  end

  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating, :reviewer_full_name
    def reviewer_full_name
      object.user&.full_name
    end
  end

end
