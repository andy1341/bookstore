class Author < ApplicationRecord
  has_many :books
  validates :firstname, :lastname, presence: true
  validates :firstname, uniqueness: { scope: :lastname }

  def title
    "#{firstname} #{lastname}"
  end
end
