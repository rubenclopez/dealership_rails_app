class HomeController < ApplicationController
  def index
    @vehicles = Vehicle.all

    @vehicles_in_groups = @vehicles.in_groups_of(3)
  end
end
