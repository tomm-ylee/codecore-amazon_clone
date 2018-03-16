class Api::V1::ProductsController < Api::ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    render json: Product.order(created_at: :desc)
  end

  def show
    render json:(Product.find params[:id])
  end

  def create
    product = Product.new(params.require(:product).permit(:title, :description, :price, :sale_price))
    product.user = current_user
    product.save!

    render json: product
  end
end
