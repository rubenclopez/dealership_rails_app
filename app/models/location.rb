class Location < ActiveRecord::Base
  belongs_to :user

  has_many :vehicles, dependent: :destroy

  validates :name, :address, :city, :state, :zip, :user_id, presence: true

  def full_address
  	[address, city, state, zip].join(' ')
  end
end
