class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  has_many :reviews, as: :reviewable
  has_many :orders_items

  mount_uploader :image, ImageUploader
  validates :title, uniqueness: true
  validates :title, :price, :category, :author, presence: true

  def self.popular_books
    joins(:orders_items)
        .select('books.*, count(books.id) as count')
        .group(:id)
        .order('count DESC')
  end
end
