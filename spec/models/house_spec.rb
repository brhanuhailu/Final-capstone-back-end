require 'rails_helper'

RSpec.describe House, type: :model do
  let(:user) do
    User.new(
      username: 'test user',
      email: 'test@email.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  let(:valid_house) do
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

  it 'is valid with valid attributes' do
    expect(valid_house).to be_valid
  end

  it 'is not valid without a name' do
    valid_house.name = nil
    expect(valid_house).not_to be_valid
  end

  it 'is not valid without an area' do
    valid_house.area = nil
    expect(valid_house).not_to be_valid
  end

  it 'is not valid without the number of rooms' do
    valid_house.number_of_rooms = nil
    expect(valid_house).not_to be_valid
  end

  it 'is not valid without a location' do
    valid_house.location = nil
    expect(valid_house).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'has many reservations' do
    association = described_class.reflect_on_association(:reservations)
    expect(association.macro).to eq :has_many
  end
end
