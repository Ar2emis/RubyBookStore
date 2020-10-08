class Review < ApplicationRecord
  enum status: { unprocessed: 0, approved: 1, rejected: 2 }

  belongs_to :book
  belongs_to :user

  validates :title, :book_rate, :body, presence: true

  scope :processed, -> { where(status: %i[approved rejected]) }
  scope :with_user, -> { includes([:user]) }
end
