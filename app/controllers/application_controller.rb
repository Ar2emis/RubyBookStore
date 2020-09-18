class ApplicationController < ActionController::Base
  before_action :book_categories

  private

  def book_categories
    @book_categories = Category.all
  end
end
