class AddCouponService < BaseService
  def initialize(**kwargs)
    super
    @order = kwargs[:order]
    @params = kwargs[:params]
    @success_message = I18n.t('cart.coupon_added')
  end

  def call
    coupon = Coupon.find_by(code: @params[:code])
    return @errors << I18n.t('cart.invalid_coupon') if coupon.nil?
    return @errors << I18n.t('cart.coupon_used') unless coupon.active?

    @order.coupon = coupon
    coupon.update(active: false)
  end
end
