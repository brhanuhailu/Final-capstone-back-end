class House < ApplicationRecord
  belongs_to :user
  has_many :reservations
  validates :area, :number_of_rooms, :location, :name, presence: true
end
