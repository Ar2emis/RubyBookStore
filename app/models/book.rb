class Book < ApplicationRecord
  SORT_PARAMTERS = {
    newest: { created_at: :desc },
    cheap: :price,
    expensive: { price: :desc },
    atoz: :title,
    ztoa: { title: :desc }
  }.freeze

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  belongs_to :category

  mount_uploader :title_image, ImageUploader
  mount_uploaders :images, ImageUploader

  scope :ordered, ->(order_type) { order(SORT_PARAMTERS.fetch(order_type, SORT_PARAMTERS[:newest])) }
  scope :with_authors, -> { includes(:authors) }
end
