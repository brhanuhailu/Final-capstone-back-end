class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :user

  def index
    @reservations = @user.reservations.all
    render json: @reservations
  end

  def create
    @house = House.find(params[:house_id])
    @reservation = @house.reservations.build(reserv_params)
    @reservation.total_charge = total_charge(@house.price, @reservation.booking_date, @reservation.checkout_date)
    # puts @reservation.total_charge
    @reservation.user_id = @user.id
    if @reservation.save
      @reservations = @user.reservations.all
      render json: @reservations, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @user.id == @reservation.user_id
      @reservation.destroy
      @reservations = @user.reservations.all
      render json: @reservations, status: :created
    else
      render json: { error: 'you are not allowed to delete' }, status: :unprocessable_entity
    end
  end

  def my_reservations
    reservations = Reservation.includes(:house).where(user_id: current_user.id)
    render json: reservations
  end

  private

  def user
    @user = current_user
  end

  def reserv_params
    params.require(:reservation).permit(:booking_date, :checkout_date)
  end

  def total_charge(price, start_date, end_date)
    difference = (end_date - start_date).to_i
    difference * price
  end
end
