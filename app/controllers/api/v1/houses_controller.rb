class Api::V1::HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_houses, only: [:index, :destroy]
  def index
    user = current_user
    render json: @houses
  end

  def new
    user = current_user
    @house = House.new
    render json: @house
  end

  def create
    user = current_user
    @house = user.houses.build(house_params)
    if @house.save
      render json: @house , status: :created
    else
      render json: { errors: @house.errors.full_messages }, status: :unprocessable_entity
    end

  end

  def show
    @house = House.find(params[:id])
    render json: @house

  end

  def destroy
    
  end

  private

  def set_houses
    @houses = House.all
  end

  def house_params
    params.require(:house).permit(:name, :area, :number_of_rooms, :location, :description)
  end
end
