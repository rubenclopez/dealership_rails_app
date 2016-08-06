require 'rails_helper'

describe HomeHelper, type: :helper do
  let(:location) { FactoryGirl.build(:location) }

  context "#format_location" do
    it "displays the location formatted string" do
      expect(helper.format_location(location)).to eql('Test City, UT')
    end
  end

  context "#available_sold_state" do
    let(:vehicle) { FactoryGirl.build(:vehicle) }
    let(:user) { FactoryGirl.create(:user, email: 'test@test.com')}

    it "should return a span with available properties" do
      tag = '<span class="label label-primary" data-ds-buy-button="span" data-vehicle-id="null">Available</span>'

      expect(helper.available_sold_state(vehicle)).to eql(tag)
    end

    it "should return a span with sold properties" do
      tag = '<span class="label label-danger" disabled="disabled" data-ds-buy-button="span" data-vehicle-id="1">Sold At: $10.55</span>'

      vehicle.update_attributes(sold_at: Time.now, sold_at_price: 10.55)

      expect(helper.available_sold_state(vehicle)).to eql(tag)
    end

    context "when user is logged in" do
      let!(:user) { FactoryGirl.create(:user_with_salesman_role, email: 'test@test.com') }

      before { sign_in user }

      it "should return a button with available properties" do
        tag = '<button class="btn btn-primary button-buy" data-ds-buy-button="button" data-vehicle-id="null">Available</button>'

        expect(helper.available_sold_state(vehicle)).to eql(tag)
      end

      it "should return a button with sold properties" do
        tag = '<button class="btn btn-danger button-buy" disabled="disabled" data-ds-buy-button="button" data-vehicle-id="1">Sold At: $10.55</button>'

        vehicle.update_attributes(sold_at: Time.now, sold_at_price: 10.55)
        expect(helper.available_sold_state(vehicle)).to eql(tag)
      end
    end
  end
end