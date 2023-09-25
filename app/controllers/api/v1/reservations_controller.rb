class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  def index
    @reservations = @user.reservations.all
    render json: @reservations
  end

  private

  def get_user
    @user = current_user
  end

  def reserv_params
    params.require(:reservation).permit(:booking_date, :checkout_date, :total_charge)
  end
end
