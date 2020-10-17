class ReviewForm < BaseForm
  TEXT_FORMAT = %r/\A[\w!#$%&'*+-\/=?^`{|}~\s]+\z/.freeze
  RATE_MIN = 0
  RATE_MAX = 5
  TITLE_MAX_LENGTH = 80
  BODY_MAX_LENGTH = 500

  validates :title, :book_rate, :body, :book_id, presence: true
  validates :title, format: { with: TEXT_FORMAT }, length: { maximum: TITLE_MAX_LENGTH }
  validates :body, format: { with: TEXT_FORMAT }, length: { maximum: BODY_MAX_LENGTH }
  validates :book_rate, numericality: { greater_than_or_equal_to: RATE_MIN, less_than_or_equal_to: RATE_MAX }

  attr_accessor :title, :book_rate, :body, :book_id, :user

  def submit
    Review.create(@params)
  end
end
