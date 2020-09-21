class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.create(review_params)
    return redirect_back(fallback_location: books_path, notice: I18n.t('reviews.success')) if @review.valid?

    @book_id = review_params[:book_id]
  end

  private

  def review_params
    params.require(:review).permit(:title, :book_rate, :body, :book_id)
          .merge(user: current_user, date: Time.zone.today)
  end
end
