class UpdateCartService < BaseService
  attr_reader :success_message

  def initialize(**kwargs)
    super
    @params = kwargs[:params]
    @order = kwargs[:order]
  end

  def call
    if @params.key?(:order_item) then update_order_item(@params[:order_item])
    elsif @params.key?(:coupon) then update_coupon(@params[:coupon])
    end
    @order.reload
  end

  private

  def update_order_item(order_item_params)
    order_item = @order.order_items.find_by(book_id: order_item_params[:book_id])
    if order_item
      order_item.update(amount: order_item.amount + order_item_params[:amount].to_i)
    else
      order_item = @order.order_items.create(order_item_params)
    end
    order_item.valid? ? @success_message = I18n.t('flash.book_added') : @errors << I18n.t('flash.error')
  end

  def update_coupon(coupon_params)
    coupon = Coupon.find_by(code: coupon_params[:code])
    return @errors << I18n.t('cart.invalid_coupon') if coupon.nil?
    return @errors << I18n.t('cart.coupon_used') unless coupon.active?

    @order.coupon = coupon
    coupon.update(active: false)
    @success_message = I18n.t('cart.coupon_added')
  end
end
