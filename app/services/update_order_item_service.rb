class UpdateOrderItemService < BaseService
  def initialize(**kwargs)
    super
    @params = kwargs[:params]
    @order = kwargs[:order]
  end

  def call
    if @params.key?(:delete_id)
      @order.order_items.where(id: @params[:delete_id]).destroy_all
    else
      update_amount
    end
  end

  def update_amount
    order_item = @order.order_items.find_or_initialize_by(book_id: @params[:book_id])
    @params[:amount] = order_item.amount + @params[:amount].to_i if order_item.persisted?
    order_item.update(@params)
    order_item.valid? ? @success_message = I18n.t('flash.book_added') : @errors << I18n.t('flash.error')
  end
end
