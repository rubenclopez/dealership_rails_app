class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :heading
      t.string :description
      t.string :make
      t.string :model
      t.integer :year
      t.decimal :sold_at_price, precision: 10, scale: 2
      t.timestamp :sold_at
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
