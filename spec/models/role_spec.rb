require 'rails_helper'

describe Role, type: :model do
  subject { FactoryGirl.create(:role) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:users) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it "should return the correct role using the [] method" do
    expect(described_class['test_role']).to eql Role.find_by_name('test_role')
  end
end