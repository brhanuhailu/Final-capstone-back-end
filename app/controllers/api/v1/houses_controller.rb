class Api::V1::HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_houses, only: [:index, :destroy]
  def index
    user = current_user
    render json: @houses
  end

  def new
    

  end

  def create


  end

  def show
   
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
