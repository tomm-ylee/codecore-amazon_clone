class ReviewAddedMailer < ApplicationMailer
  def notify_product_owner(review)
    @review = review
    @product = review.product
    mail(
      to: @product.user.email,
      subject: "Amazon: Someone left a review for [#{@product.title}]"
    )
  end
end
