class ApplicationController < ActionController::Base
  helper_method :categories, :countries

  private

  def categories
    Category.all
  end

  def countries
    ISO3166::Country.all.sort_by(&:name)
  end
end
