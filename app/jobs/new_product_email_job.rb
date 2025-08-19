class NewProductEmailJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find(product_id)

    User.find_each do |user|
      ProductMailer.new_product_email(user, product).deliver_later
    end
  end
end
