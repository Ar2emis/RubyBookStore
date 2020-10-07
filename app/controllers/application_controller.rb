class ApplicationController < ActionController::Base
  helper_method :categories, :countries

  private

  def categories
    Category.all
  end
end
