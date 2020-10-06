class ApplicationController < ActionController::Base
  before_action :categories

  private

  def categories
    @categories = Category.all
  end
end
