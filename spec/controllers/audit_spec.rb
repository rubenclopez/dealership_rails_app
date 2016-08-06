require 'rails_helper'

describe AuditsController, type: :controller do
  let!(:manager_user) { FactoryGirl.create(:user_with_manager_role, email: 'test@test.com') }
  let!(:owner_user) { FactoryGirl.create(:user_with_owner_role, email: 'test2@test.com') }

  context "GET #index" do
    it "responds to the index route" do
      sign_in owner_user

      get :index
      expect(response).to be_success
    end

    it "fails when not logged in" do
      get :index
      expect(response).to_not be_success
    end

    it "fails when logged in with an account that does not have owner role" do
      sign_in manager_user

      get :index
      expect(response).to_not be_success
    end
  end
end