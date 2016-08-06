require 'rails_helper'

describe HomeController, type: :controller do
  context "GET #index" do
    it "responds to the index route" do
      get :index
      expect(response).to be_success
    end
  end
end