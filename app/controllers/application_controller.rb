class ApplicationController < ActionController::Base
  helper_method :categories

  private

  def categories
    Category.all
  end
end
