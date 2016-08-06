require 'rails_helper'

describe Vehicle, type: :model do
  subject { FactoryGirl.create(:vehicle) }

  it { is_expected.to belong_to(:location) }
  it { is_expected.to have_one(:audit) }
  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:heading) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:make) }
  it { is_expected.to validate_presence_of(:model) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:location) }

  it { is_expected.to callback(:add_sold_at_timestamp).before(:save) }

  it "returns only items marked as sold" do
    expect { FactoryGirl.create(:sold_vehicles) }
      .to change{ Vehicle.sold.count }.by(1)
  end

  it "checks to see if a vehicle has been sold" do
    expect { subject.update_attributes(sold_at: Time.now, sold_at_price: 1000.50) }
      .to change { subject.has_been_sold? }
  end
end