require 'rails_helper'

describe VehiclesController, type: :controller do
  let!(:salesman_user) { FactoryGirl.create(:user_with_salesman_role, email: 'test@test.com') }
  let!(:owner_user) { FactoryGirl.create(:user_with_owner_role, email: 'test2@test.com') }

  context "GET #index" do
    it "responds to the index route" do
      sign_in owner_user

      get :index
      expect(response).to be_success
    end

    it "should fail if user is not logged in" do
      get :index
      expect(response).to_not be_success
    end

    it "should fail if user does not have owner role" do
      sign_in salesman_user

      get :index
      expect(response).to_not be_success
    end
  end

  context "POST #create" do
    before do
      request.accept = 'application/json'

      @heading = 'post test name'
      @location = FactoryGirl.create(:location)
      @vehicle = FactoryGirl.attributes_for(:vehicle, heading: @heading)
                  .merge(location: @location.id)
    end

    it "creates new vehicle" do
      sign_in owner_user

      post :create, vehicle: @vehicle
      expect(Vehicle.last.heading).to eql(@heading)
    end

    it "fails to create a new vehicle if user does not have owner role" do
       sign_in salesman_user

       post :create, vehicle: @vehicle
       expect(response).to_not be_success
    end
  end

  context "PATCH update" do
    before do
      @vehicle = FactoryGirl.create(:vehicle)
      request.accept = 'application/json'
    end

    it "updates vehicle" do
      sign_in owner_user

      heading = 'test update heading'
      patch :update, id: @vehicle.id, vehicle: {heading: heading}

      expect(Vehicle.last.heading).to eql(heading)
    end

    it "updates vehicle if user is logged in" do
       sign_in salesman_user

       patch :update, id: @vehicle.id, vehicle: {heading: ''}
       expect(response).to be_success
    end

    it "fails to update if not logged in" do
      patch :update, id: @vehicle.id, vehicle: {heading: ''}
      expect(response).to_not be_success
    end
  end

  context "DELETE destroy" do
    before do
      @vehicle = FactoryGirl.create(:vehicle)
      request.accept = 'application/json'
    end

    it "deletes vehicle" do
      sign_in owner_user

      delete :destroy, id: @vehicle.id
      expect(Vehicle.count).to eql(0)
    end

    it "fails delete vehicle if user does not have owner role" do
       sign_in salesman_user

       delete :destroy, id: @vehicle.id
       expect(response).to_not be_success
    end
  end
end