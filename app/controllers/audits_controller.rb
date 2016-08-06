class AuditsController < ApplicationController
  respond_to :json, :html

  before_action :authenticate_user!
  before_action :check_roles

  def index
    @audits = Audit.all.map do |audit|
      {
        vehicle_id: audit.vehicle.id,
        vehicle_name: audit.vehicle.heading,
        vehicle_location: audit.vehicle.location.full_address,
        seller_id: audit.user.id,
        sold_on: audit.created_at,
        sold_by: audit.user.full_name,
        sold_for: audit.vehicle.sold_at_price
      }
    end

    respond_with(@audits)
  end

  private 

  def check_roles
    if current_user.roles.include?(Role['owner'])
      true
    else
      redirect_to root_path
    end
  end
end
