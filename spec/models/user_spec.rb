require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) do
    User.new(
      username: 'test user',
      email: 'test@email.com',
      password: '12345678',
      password_confirmation: '12345678'
    )
  end

  before(:each) do
    valid_user.save
  end

  it 'is valid with valid attributes' do
    expect(valid_user).to be_valid
  end

  it 'is not valid without an email' do
    valid_user.email = nil
    expect(valid_user).not_to be_valid
  end

  it 'is not valid without a username' do
    valid_user.username = nil
    expect(valid_user).not_to be_valid
  end

  it 'has many houses' do
    association = described_class.reflect_on_association(:houses)
    expect(association.macro).to eq :has_many
  end

  it 'has many reservations' do
    association = described_class.reflect_on_association(:reservations)
    expect(association.macro).to eq :has_many
  end
end
