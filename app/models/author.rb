class Author < ApplicationRecord
  has_many :books

  def title
    "#{firstname} #{lastname}"
  end
end
