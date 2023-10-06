class House < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :area, :number_of_rooms, :location, :name, :price, :image, presence: true
end
