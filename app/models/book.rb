class Book < ApplicationRecord
  MIN_PRICE = 0.0
  SORT_PARAMTERS = {
    newest: { created_at: :desc },
    cheap: :price,
    expensive: { price: :desc },
    atoz: :title,
    ztoa: { title: :desc },
    popularity: { items_count: :desc }
  }.freeze

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: MIN_PRICE }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :category

  mount_uploader :title_image, ImageUploader
  mount_uploaders :images, ImageUploader

  scope :with_authors, -> { includes(:authors) }
  scope :with_items_count, lambda {
    left_joins(:order_items).select('books.*', 'count(order_items.id) as items_count').group('books.id')
  }
  scope :ordered, lambda { |order_type|
    books = order_type == :popularity ? with_items_count : all
    books.order(SORT_PARAMTERS.fetch(order_type, SORT_PARAMTERS[:newest]))
  }
end
