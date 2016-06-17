class Book < ApplicationRecord
  belongs_to :author
  belongs_to :category
  mount_uploader :image, ImageUploader
  validates :title, uniqueness: true
  validates :price, :category_id, :author_id, presence: true
end
