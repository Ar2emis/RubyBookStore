class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :categories

  private

  def categories
    @categories = Category.all
  end
end
