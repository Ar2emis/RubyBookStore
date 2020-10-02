class FilteredOrdersQuery
  STATES = %i[in_queue in_delivery delivered canceled].freeze

  def self.call(filter_state, user)
    orders = Order.where(user: user).finished_by_user.order(created_at: :desc)
    orders = orders.where(state: filter_state) if STATES.include?(filter_state&.to_sym)
    orders
  end
end
