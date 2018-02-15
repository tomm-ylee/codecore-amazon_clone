class Admin::PanelController < ApplicationController
  before_action :authorize_user!, only: [:index]

  def index
    @products = Product.all
    @reviews = Review.all
    @users = User.all
  end

  private

  def authorize_user!
    unless current_user&.is_admin?
      flash[:alert] = 'Admin access only'
      redirect_to root_path
    end
  end
end
