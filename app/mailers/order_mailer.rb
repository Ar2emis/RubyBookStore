class OrderMailer < ApplicationMailer
  def order_complete_mail(order)
    @order = order.decorate
    mail(to: @order.user.email, subject: I18n.t('order_mailer.subject', number: @order.number))
  end
end
