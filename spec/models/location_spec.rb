require 'rails_helper'

describe Location, type: :model do
  subject { FactoryGirl.create(:location) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:vehicles) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:zip) }
  it { is_expected.to validate_presence_of(:user_id) }

  it "destroys child 'vehicles' when parent 'location' is destroyed" do
    location = FactoryGirl.create(:location_with_vehicle)

    expect { location.destroy }.to change{ Vehicle.count }.by(-1)
  end
end