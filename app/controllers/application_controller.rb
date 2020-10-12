class ApplicationController < ActionController::Base
  before_action :build_shopping_cart
  helper_method :categories

  private

  def categories
    @categories ||= Category.all
  end

  def build_shopping_cart
    @shopping_cart = BuildCartService.call(session: session, user: current_user).shopping_cart
  end
end
