class SessionsController < Devise::SessionsController
  def create
    super { transfer_cart_to_user }
  end
end
