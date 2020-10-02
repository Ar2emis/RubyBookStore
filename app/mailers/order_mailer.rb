class OrderMailer < ApplicationMailer
  def order_complete_mail(order)
    @order = order.decorate
    mail(to: @order.user.email, subject: "Order ##{@order.number} created successfuly!")
  end
end
