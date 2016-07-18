class Category < ApplicationRecord
  has_many :books
  validates :name, presence: true, uniqueness: true

  scope :with_books, -> { joins(:books).distinct }
end
