class CartItemsController < ApplicationController
  def create
    @cart.cart_items.create!(cart_item_params)
    redirect_back_with_message(t('flash.book_successfuly_added'), :success)
  rescue ActiveRecord::RecordInvalid
    redirect_back_with_message(t('flash.error'), :error)
  end

  private

  def redirect_back_with_message(message, type)
    redirect_back(fallback_location: root_path)
    flash[type] = message
  end

  def cart_item_params
    params.require(:cart_item).permit(:book_id, :quantity)
  end
end
