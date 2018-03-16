class CreateProductMailer < ApplicationMailer
  def notify_product_owner(product)
    @product = product
    mail(
      to: @product.user.email,
      subject: "You added [#{@product.title}]"
    )
  end
end
