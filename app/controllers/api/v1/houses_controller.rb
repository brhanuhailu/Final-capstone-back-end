class Api::V1::HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_houses, only: %i[index destroy]
  def index
    current_user
    render json: @houses
  end

  def create
    user = current_user
    @house = user.houses.build(house_params)
    if @house.save
      render json: @house, status: :created
    else
      render json: { errors: @house.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @house = House.find(params[:id])
    render json: @house
  end

  def destroy
    user = current_user
    @house = House.find(params[:id])
    if user.id == @house.user_id
      @house.destroy
      render json: @houses
    else
      render json: { error: 'you are not allowed to delete' }, status: :unprocessable_entity
    end
  end

  private

  def set_houses
    @houses = House.all
  end

  def house_params
    params.require(:house).permit(:name, :area, :number_of_rooms, :location, :description, :price)
  end
end
