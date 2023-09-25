class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def index
    @reservations = @user.reservations.all
    render json: @reservations
  end

  def create
    @house = House.find(params[:house_id])
    @reservation = @house.reservations.build(reserv_params)
    @reservation.user_id = @user.id
    if @reservation.save
      @reservations = @user.reservations.all
      render json: @reservations, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def get_user
    @user = current_user
  end

  def reserv_params
    params.require(:reservation).permit(:booking_date, :checkout_date, :total_charge)
  end
end
