class UpdateCartService < BaseService
  def initialize(**kwargs)
    super
    @params = kwargs[:params]
    @order = kwargs[:order]
  end

  def call
    service = if @params.key?(:order_item)
                UpdateOrderItemService.call(order: @order, params: @params[:order_item])
              elsif @params.key?(:coupon)
                AddCouponService.call(order: @order, params: @params[:coupon])
              end
    return unless service

    transfer_result(service)
    @order.reload
  end

  private

  def transfer_result(service)
    @success_message = service.success_message
    @errors = service.errors
  end
end
