require 'rails_helper'

describe Audit, type: :model do
  subject { FactoryGirl.create(:audit) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:vehicle_id) }
  it { is_expected.to validate_presence_of(:vehicle_name) }
  it { is_expected.to validate_presence_of(:vehicle_location) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:sold_by) }
  it { is_expected.to validate_presence_of(:sold_for) }
  it { is_expected.to validate_numericality_of(:vehicle_id) }
  it { is_expected.to validate_numericality_of(:user_id) }
end