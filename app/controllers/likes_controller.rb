class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find params[:review_id]
    like = Like.new user: current_user, review: review

    if !can? :like, review
      redirect_to review.product, alert: 'You can\'t like your own review.'
    elsif like.save
      redirect_to review.product, notice: 'Liked.'
    else
      redirect_to review.product, alert: 'Like failed.'
    end
  end

  def destroy
    like = Like.find_by id: params[:id]
    if can? :destroy, like
      like.destroy
      redirect_to like.review.product, notice: 'Unliked.'
    else
      redirect_to like.review.product, alert: 'Not yours to unlike'
    end
  end

end
