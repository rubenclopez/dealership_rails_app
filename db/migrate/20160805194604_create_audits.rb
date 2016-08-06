class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.references :user, index: true, foreign_key: true
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
