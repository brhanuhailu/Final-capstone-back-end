class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :house

  validates :booking_date, :checkout_date, presence: true
  validates :total_charge, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
