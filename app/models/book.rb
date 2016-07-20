class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :reviews, as: :reviewable
  has_many :orders_items
  POPULAR_COUNT = 10
  mount_uploader :image, ImageUploader
  validates :title, uniqueness: true
  validates :title, :price, :category, :author, presence: true
  delegate :proved, :unproved, to: :reviews, prefix: true

  scope :ordered_books, -> do
    joins(:orders_items)
      .select('books.*')
      .group('books.id')
      .limit(POPULAR_COUNT)
  end

  def self.popular_books
    return Book.limit(POPULAR_COUNT) if ordered_books.empty?
    ordered_books
  end
end
