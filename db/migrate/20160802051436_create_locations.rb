class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
