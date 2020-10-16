class BuildOrderService < BaseService
  attr_reader :current_order

  def initialize(**kwargs)
    super
    @session = kwargs[:session]
    @user = kwargs[:user]
  end

  def call
    transfer_order_to_user if @user && @session[:current_order]
    @current_order = build_order
  end

  private

  def build_order
    if @user
      @user.current_order
    elsif @session[:current_order]
      Order.find(@session[:current_order])
    else
      order = Order.create
      @session[:current_order] = order.id
      order
    end
  end

  def transfer_order_to_user
    order = Order.find(@session[:current_order])
    @user.current_order = order if order.order_items.any? || @user.current_order.nil?
    @session[:current_order] = nil
  end
end
