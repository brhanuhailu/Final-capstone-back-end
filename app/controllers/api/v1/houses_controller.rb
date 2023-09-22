class Api::V1::HousesController < ApplicationController
  
  def index
    
  end

  def new

  end

  def create
  end

  def show
  end

  def delete
  end

  def house_params
    params.require(:house).permit(:name, :area, :number_of_rooms, :location, :description)
  end
end
