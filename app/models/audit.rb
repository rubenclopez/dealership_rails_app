class Audit < ActiveRecord::Base
  belongs_to :user
  belongs_to :vehicle

  validates :vehicle_id, :vehicle_name, :vehicle_location, :user_id,
            :sold_by, :sold_for, presence: true
  validates :vehicle_id, :user_id, numericality: true
end