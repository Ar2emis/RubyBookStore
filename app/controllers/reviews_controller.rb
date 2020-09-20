class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review_form = ReviewForm.new(review_params)
    if @review_form.valid?
      @review_form.save
      redirect_back(fallback_location: books_path, notice: 'Fuck')
    else
      @presenter = BookPresenter.new(view: view_context, book: @review_form.book)
      render 'books/show'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: books_path)
  end

  private

  def review_params
    params.require(:review).permit(:title, :book_rate, :body, :book_id, :user).merge(user: current_user)
  end
end
