class AddCouponService < BaseService
  def initialize(**kwargs)
    super
    @coupon = Coupon.find_by(code: kwargs[:coupon_params][:code])
    @cart = kwargs[:cart]
  end

  def call
    validate
    return unless success?

    @cart.update(coupon: @coupon)
    @cart.user.coupons << @coupon if @cart.user
  end

  private

  def validate
    return @errors << I18n.t('cart.invalid_coupon') if @coupon.nil?

    @errors << I18n.t('cart.coupon_used') if @cart.user&.coupons&.include?(@coupon)
  end
end
