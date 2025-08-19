class ProductMailer < ApplicationMailer
  def new_product_email(user, product)
    @user = user
    @product = product

    mail(
      to: @user.email,
      subject: "New Product: #{@product.name}"
    )
  end
end
