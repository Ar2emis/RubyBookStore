class Book < ApplicationRecord
  include Sortable

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }

  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent: :destroy
  belongs_to :category

  has_one_attached :title_image, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  scope :with_authors, -> { includes([:authors]) }
  scope :sort_atoz, -> { order(:title) }
  scope :sort_ztoa, -> { order(title: :desc) }
  scope :sort_cheap, -> { order(:price) }
  scope :sort_expensive, -> { order(price: :desc) }
  scope :sort_newest, -> { order(created_at: :desc) }
end
