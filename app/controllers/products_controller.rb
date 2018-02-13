class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews.order(created_at: :desc)
  end

  def index
    @products = Product.order(updated_at: :desc)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find params[:id]

    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

end
