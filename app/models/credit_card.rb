class CreditCard < ApplicationRecord
  validates :number, presence: true, format: /\d{16}/
  validates :expiration_month, presence: true, inclusion: 1..12
  validates :expiration_year, presence: true, inclusion: years
  validates :code, presence: true, format: /\d{3}/

  private
  def years
    now = Time.now.strftime("%y").to_i
    to = 20.years.since.strftime('%y').to_i
    (now..to).to_a
  end
end
