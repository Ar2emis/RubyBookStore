class Review < ApplicationRecord
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }

  TEXT_FORMAT = %r/\A[\w!#$%&'*+-\/=?^`{|}~\s]+\z/.freeze
  RATE_MIN = 0
  RATE_MAX = 5
  TITLE_MAX_LENGTH = 80
  BODY_MAX_LENGTH = 500

  validates :title, :book_rate, :body, :book_id, presence: true
  validates :title, format: { with: TEXT_FORMAT }, length: { maximum: TITLE_MAX_LENGTH }
  validates :body, format: { with: TEXT_FORMAT }, length: { maximum: BODY_MAX_LENGTH }
  validates :book_rate, numericality: { greater_than: RATE_MIN, less_than_or_equal_to: RATE_MAX },
                        if: -> { book_rate.present? }
  validate :book_existance, if: -> { book_id.present? }

  belongs_to :book
  belongs_to :user

  scope :processed, -> { where(status: %i[approved rejected]) }
  scope :with_user, -> { includes([:user]) }

  private

  def book_existance
    errors.add(:book_id, :required) unless Book.exists?(id: book_id)
  end
end
