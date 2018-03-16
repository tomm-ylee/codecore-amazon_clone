class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_vote, only: [:update, :destroy]

  def create
    review = Review.find params[:review_id]
    vote = Vote.new(user: current_user, review: review, choice: params[:choice])

    vote.save ? redirect_to(review.product) : redirect_to(review.product, alert: "Voting failed")
  end

  def update
    if @vote.update choice: params[:choice]
      redirect_to @vote.review.product
    else
      redirect_to @vote.review.product, alert: @vote.errors.full_messages.join(', ')
    end
  end

  def destroy
    @vote.destroy
    redirect_to @vote.review.product
  end

  private

  def find_vote
    @vote = Vote.find params[:id]
  end
end
