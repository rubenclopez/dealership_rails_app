class Role < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, uniqueness: true, presence: true

  VALID_ROLES = [
    'owner', 'manager', 'salesman'
  ]

  def self.[](role)
    self.find_or_create_by(name: role.downcase)
  end
end
