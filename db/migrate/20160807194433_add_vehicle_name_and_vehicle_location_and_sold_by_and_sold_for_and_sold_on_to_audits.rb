class AddVehicleNameAndVehicleLocationAndSoldByAndSoldForAndSoldOnToAudits < ActiveRecord::Migration
  def change
    add_column :audits, :vehicle_name, :string
    add_column :audits, :vehicle_location, :string
    add_column :audits, :sold_by, :string
    add_column :audits, :sold_for, :decimal, precision: 10, scale: 2
  end
end
