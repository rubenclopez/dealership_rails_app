require 'rails_helper'

describe User, type: :model do
  subject { FactoryGirl.create(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:locations) }
  it { is_expected.to have_many(:roles) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  # TODO: Wrap these with a 'context block'
  it "destroys child locations when parent user is destroyed" do
    user = FactoryGirl.create(:user_with_location)
    expect { user.destroy }.to change{ Location.count }.by(-1)
  end

  it "should return the full name of the user" do
    expect(subject.full_name).to eql('Test User')
  end

  it "should return the first role for that user" do
    user = FactoryGirl.create(:user_with_owner_role)
    expect(user.with_role).to eql('Test User (Owner)')
  end

  it "should return true if role is found for user" do
    user = FactoryGirl.create(:user_with_owner_role)
    expect(user.has_roles?('test', 'owner', 'blah')).to be_truthy
  end

  it "should return false if role is not found for user" do
    user = FactoryGirl.create(:user_with_salesman_role)
    expect(user.has_roles?('test', 'owner', 'blah')).to be_falsy
  end

end