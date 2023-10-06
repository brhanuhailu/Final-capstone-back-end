require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) do
    User.new(
      username: 'test user',
      email: 'test@email.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  let(:house) do
    House.new(
      user:,
      name: 'Example House',
      area: 100,
      number_of_rooms: 3,
      location: 'Sample Location',
      price: '200.67',
      image: 'https://img.freepik.com/free-photo/blue-house-with-blue-roof-sky-background_1340-25953.jpg?size=626&ext=jpg'
    )
  end

  let(:reservation) do
    Reservation.new(
      booking_date: Date.today,
      checkout_date: Date.today + 2,
      total_charge: 100.0,
      user:,
      house:
    )
  end

  it 'is valid with valid attributes' do
    expect(reservation).to be_valid
  end

  it 'is not valid without a booking date' do
    reservation.booking_date = nil
    expect(reservation).not_to be_valid
  end

  it 'is not valid without a checkout date' do
    reservation.checkout_date = nil
    expect(reservation).not_to be_valid
  end

  it 'is not valid without a total charge' do
    reservation.total_charge = nil
    expect(reservation).not_to be_valid
  end

  it 'is not valid with a negative total charge' do
    reservation.total_charge = -50.0
    expect(reservation).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'belongs to a house' do
    association = described_class.reflect_on_association(:house)
    expect(association.macro).to eq :belongs_to
  end
end
