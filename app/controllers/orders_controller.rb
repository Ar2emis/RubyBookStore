class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @presenter = OrdersPresenter.new(view: view_context, state: params[:state],
                                     orders: FilteredOrdersQuery.call(params[:state], current_user).decorate)
  end

  def show
    order = current_user.orders.finished_by_user.find_by(id: params[:id])
    return redirect_to(orders_path, alert: I18n.t('orders.order_not_found')) unless order

    @order = order.decorate
  end
end
