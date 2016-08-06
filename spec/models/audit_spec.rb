require 'rails_helper'


describe Audit, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:vehicle) }
end