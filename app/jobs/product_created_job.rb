class ProductCreatedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    CreateProductMailer.notify_product_owner(Product.last).deliver_now
  end
end
