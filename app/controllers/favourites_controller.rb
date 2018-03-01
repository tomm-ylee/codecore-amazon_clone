class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find params[:product_id]
    favourite = Favourite.new user: current_user, product: product
    if !can? :favourite, product
      redirect_to product, alert: 'You can\'t favourite this.'
    elsif favourite.save
      redirect_to product, notice: 'Favourite added.'
    else
      redirect_to product, alert: 'Favouriting failed.'
    end
  end

  def destroy
    favourite = Favourite.find_by id: params[:id]
    if can? :destroy, favourite
      favourite.destroy
      redirect_to favourite.product, notice: 'Favourite removed.'
    else
      redirect_to favourite.product, alert: 'Not yours to unfavourite'
    end
  end

  def index
    @user = User.find_by id: params[:user_id]
    @products = @user.favourite_products
  end


end
