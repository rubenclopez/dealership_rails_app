class LocationsController < ApplicationController
  respond_to :json, :html

  before_action :authenticate_user!
  before_action :set_location, only: [:update, :destroy]
  before_action :check_roles
  before_action :simulate_latency, only: [:create, :destroy]

  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def create
    sanitized_params = permitted_params
    sanitized_params.merge!(user: current_user)

    @location = Location.create(sanitized_params)

    respond_with(@location)
  end

  def update
    @location.tap do |location|
      location.update_attributes(permitted_params)
    end

    respond_with(@location)
  end

  def destroy
    @location.destroy

    respond_with(@location)
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  # TODO: Extract into a class
  def check_roles
    if current_user.roles.include?(Role['owner'])
      return true
    elsif request.format.symbol == :json && params[:action] == 'index'
      return true
    end

    redirect_to root_path
  end

  def permitted_params
    params.require(:location).permit(:name, :address, :city, :state, :zip)
  end
end
