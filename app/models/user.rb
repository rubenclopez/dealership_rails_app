class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations, dependent: :destroy

  has_many :memberships
  has_many :roles, through: :memberships

  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(" ")
  end

  alias_method :to_s, :full_name

  def with_role
    "#{full_name} (#{roles.first.name.humanize})"
  end

  def has_roles?(*roles)
    roles.map do |role|
      return true if self.roles.include?(Role[role])
    end

    false
  end
end
