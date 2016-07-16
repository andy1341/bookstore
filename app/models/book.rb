class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :reviews, as: :reviewable
  has_many :orders_items
  POPULAR_COUNT = 10
  mount_uploader :image, ImageUploader
  validates :title, uniqueness: true
  validates :title, :price, :category, :author, presence: true

  def self.popular_books
    ordered_books || Book.limit(POPULAR_COUNT)
  end

  private

  def self.ordered_books
    joins(:orders_items)
      .select('books.*, count(books.id) as count')
      .group(:id)
      .limit(POPULAR_COUNT)
      .order('count DESC')
  end
end
