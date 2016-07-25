class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.admin?(user)
    !!find_by_email(user.email)
  end
end
