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

  has_one_attached :title_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  scope :ordered, ->(order_type) { order(SORT_PARAMTERS.fetch(order_type, SORT_PARAMTERS[:newest])) }
  scope :with_authors, -> { includes(:authors) }
end
