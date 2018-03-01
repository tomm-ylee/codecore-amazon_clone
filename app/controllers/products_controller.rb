class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, except: [:new, :create, :index]
  before_action :authorize_user!, only:  [:edit, :update, :destroy]

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
    @review = Review.new
    @reviews = @product.reviews.order(created_at: :desc)

    @favourite = @product.favourites.find_by(user_id: current_user) if current_user.present?
  end

  def index
    @products = Product.order(updated_at: :desc)
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  def edit
  end

  def update
    if @product.sale_price > @product.price
      temp_sale = @product.sale_price
      @product.sale_price = @product.price
    end

    if @product.update product_params
      redirect_to product_path(@product)
    else
      @product.sale_price = temp_sale
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    unless can?(:crud, @product)
      flash[:alert] = 'Access denied'
      redirect_to product_path(@product)
    end
  end


end
