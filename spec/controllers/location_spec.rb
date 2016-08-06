require 'rails_helper'

describe LocationsController, type: :controller do
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

    it "should succeed if the accept header is json" do
      sign_in salesman_user

      request.accept = 'application/json'
      get :index
      expect(response).to be_success
    end
  end

  context "POST #create" do
    before do
      request.accept = 'application/json'
    end

    it "creates new location" do
      sign_in owner_user

      name = 'post test name'
      location = FactoryGirl.attributes_for(:location, name: name)

      post :create, location: location
      expect(Location.last.name).to eql(name)
    end

    it "fails to create a new location if user does not have owner role" do
       sign_in salesman_user

       post :create, location: FactoryGirl.attributes_for(:location)
       expect(response).to_not be_success
    end
  end

  context "PATCH update" do
    before do
      @location = FactoryGirl.create(:location)
      request.accept = 'application/json'
    end

    it "updates location" do
      sign_in owner_user

      name = 'test update name'
      patch :update, id: @location.id, location: {name: name}

      expect(Location.last.name).to eql(name)
    end

    it "fails to update location if user does not have owner role" do
       sign_in salesman_user

       patch :update, id: @location.id, location: {name: ''}
       expect(response).to_not be_success
    end
  end

  context "DELETE destroy" do
    before do
      @location = FactoryGirl.create(:location)
      request.accept = 'application/json'
    end

    it "deletes location" do
      sign_in owner_user

      delete :destroy, id: @location.id
      expect(Location.count).to eql(0)
    end

    it "fails delete location if user does not have owner role" do
       sign_in salesman_user

       delete :destroy, id: @location.id
       expect(response).to_not be_success
    end
  end
end