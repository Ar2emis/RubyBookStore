class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    form = ReviewForm.new(review_params)
    if form.valid?
      flash[:success] = I18n.t('reviews.success')
      form.submit
    end
    redirect_back(fallback_location: books_path)
  end

  private

  def review_params
    params.require(:review).permit(:title, :book_rate, :body, :book_id).merge(user: current_user)
  end
end
