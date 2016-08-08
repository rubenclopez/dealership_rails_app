class HomeController < ApplicationController
  def index
    @vehicles = Vehicle.includes(:location).all

    @vehicles_in_groups = @vehicles.in_groups_of(3)
  end
end
