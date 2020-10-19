class CheckoutsController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    return if user_signed_in?

    store_location_for(:user, checkout_path)
    redirect_to(quick_registration_path)
  end
end
