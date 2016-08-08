class VehiclesController < ApplicationController
  respond_to :json, :html

  before_action :authenticate_user!
  before_action :set_vehicle, only: [:update, :destroy]
  before_action :audit_action, only: :update
  before_action :check_roles, except: [:update, :show]
  before_action :simulate_latency, only: [:create, :update, :destroy]

  def index
    @vehicles = Vehicle.all

    respond_with(@vehicles)
  end

  def create
    @location = Vehicle.create(permitted_params)

    respond_with(@location)
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    params = sanitize_params(permitted_params)
    @vehicle.update_attributes(params)

    respond_to do |format|
       format.html
       format.json { render json: @vehicle }
    end
  end

  def destroy
    @vehicle.destroy

    respond_with(@vehicle)
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def sanitize_params(params)
    params[:sold_at_price] = params[:sold_at_price].to_s.gsub(/[\$,]/,'')
    params
  end

  def audit_action
    sold_at_price = permitted_params[:sold_at_price]
    if sold_at_price.present? && @vehicle.sold_at.to_s.blank?
      Audit.create(vehicle_name: @vehicle.heading,
                   vehicle_location: @vehicle.location.full_address,
                   sold_by: current_user.full_name,
                   sold_for: sold_at_price,
                   vehicle_id: @vehicle.id,
                   user_id: current_user.id
      )
    end
  end

  def check_roles
    unless current_user.roles.include?(Role['owner']) || current_user.roles.include?(Role['manager'])
      redirect_to root_path
    end
  end

  def permitted_params
    sanitized_params = params.require(:vehicle).permit(
      :heading, :description, :make, :model, :year, :sold_at_price, :sold_at, :location
    )

    sanitized_params.tap do |params|
      if (location = sanitized_params[:location]).present?
        sanitized_params[:location] = Location.find(location)
      end
    end
  end
end
