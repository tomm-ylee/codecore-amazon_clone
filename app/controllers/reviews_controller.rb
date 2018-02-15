class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_review, only: [:hide, :destroy]
  before_action :authorize_user!, only: [:destroy]
  before_action :find_product, :authorize_product_user!, only: [:update]


  def create
    @review = Review.new review_params
    @review.product = @product
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else
      @reviews = @product.reviews.order(created_at: :desc)
      render 'products/show'
    end
  end

  def hide
    if @review.hidden
      @review.hidden = false
    else
      @review.hidden = true
    end
    @review.save
    redirect_to product_path(@review.product)
  end


  def destroy
    review = Review.find params[:id]
    review.destroy

    redirect_to product_path(review.product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def find_review
    @review = Review.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @review)
      flash[:alert] = 'Access denied'
      redirect_to product_path(@review.product)
    end
  end

  def find_product
    @product = Product.find params[:product_id]
  end

  def authorize_product_user!
    unless can?(:manage, @product)
      flash[:alert] = 'Access denied'
      redirect_to product_path(@product)
    end
  end
end
