class Book < ApplicationRecord
  include Sortable

  validates :title, presence: true
  validates :price, numericality: { greater_than: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  belongs_to :category

  scope :with_authors, -> { includes([:authors]) }
  scope :sort_atoz, -> { order(:title) }
  scope :sort_ztoa, -> { order(title: :desc) }
  scope :sort_cheap, -> { order(:price) }
  scope :sort_expensive, -> { order(price: :desc) }
  scope :sort_newest, -> { order(created_at: :desc) }
end
