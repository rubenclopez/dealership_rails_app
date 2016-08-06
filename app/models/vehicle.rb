class Vehicle < ActiveRecord::Base
  belongs_to :location
  has_one :audit

  before_save :add_sold_at_timestamp if -> { attribute_present?("sold_at_price") }

  validates :heading, :description, :make, :model,
            :year, :location, presence: true

  scope :sold, -> {
    where.not(sold_at: nil, sold_at_price: nil)
  }

  def has_been_sold?
    sold_at.present? && sold_at_price.present?
  end

  def sold_by
    self.audit.user
  end

  private

  def add_sold_at_timestamp
    self.sold_at = Time.now
  end
end