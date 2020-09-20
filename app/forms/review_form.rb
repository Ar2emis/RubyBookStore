class ReviewForm
  include ActiveModel::Model

  TEXT_FORMAT = %r/\A[\w!#$%&'*+-\/=?^`{|}~]\z/.freeze
  RATE_MAX = 5

  validates :title, :book_rate, :body, :book_id, presence: true
  validates :title, format: { with: TEXT_FORMAT }
  validates :body, format: { with: TEXT_FORMAT }
  validates :book_rate, numericality: { greater_than: 0, less_than_or_equal_to: RATE_MAX },
                        if: -> { book_rate.present? }
  validate :book_existance

  attr_accessor :title, :book_rate, :body, :book_id, :user

  def initialize(params = {})
    @params = params
    super(params)
  end

  def book
    Book.find(id: book_id)
  end

  def save
    Review.create(@params)
  end

  private

  def book_existance
    errors.add(:book, :required) if Book.exists?(id: book_id)
  end
end
