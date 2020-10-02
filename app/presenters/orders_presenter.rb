class OrdersPresenter < BasePresenter
  attr_reader :orders

  FILTER_STATES = {
    in_queue: 'orders.in_queue',
    in_delivery: 'orders.in_delivery',
    delivered: 'orders.delivered',
    canceled: 'orders.canceled'
  }.freeze
  STATE_COLORS = {
    in_queue: 'text-muted',
    in_delivery: 'text-primary',
    delivered: 'text-success',
    canceled: 'text-danger'
  }.freeze
  DIVIDER_CLASS = 'divider-lg-bottom pt-0'.freeze
  DATE = 'orders.date'.freeze

  def initialize(view:, orders:, state:)
    super(view: view)
    @orders = orders
    @state = state
  end

  def filter_states
    FILTER_STATES
  end

  def divider(index)
    DIVIDER_CLASS if index != orders.count - 1
  end

  def current_filter
    FILTER_STATES.fetch(@state&.to_sym, DATE)
  end

  def state_color(order)
    STATE_COLORS[order.state.to_sym]
  end
end
