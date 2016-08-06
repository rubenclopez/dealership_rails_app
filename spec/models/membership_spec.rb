require 'rails_helper'

describe Membership, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:role) }
end