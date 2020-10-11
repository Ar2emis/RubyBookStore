class UpdateCartItemService < BaseService
  def initialize(**kwargs)
    super
    @cart_item_params = kwargs[:cart_item_params]
    @book_id = @cart_item_params[:book_id]
    @amount = @cart_item_params[:amount].to_i
    @cart = kwargs[:cart]
  end

  def call
    cart_item = @cart.cart_items.find_by(book_id: @book_id)
    return @cart.cart_items.create(@cart_item_params) unless cart_item

    cart_item.update(amount: cart_item.amount + @amount)
  end
end
