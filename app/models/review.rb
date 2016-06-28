class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  belongs_to :user
  enum status: [:unproved, :proved]

  validates :text, presence: true
  validates :rating, presence: true
  validates :user, presence: true
  validates :text, uniqueness: {scope: [:reviewable_id,:user], message: "You can't add review twice"}
end
