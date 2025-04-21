require 'rails_helper'

RSpec.describe "Manager::Teams", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/manager/teams/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/manager/teams/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/manager/teams/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/manager/teams/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
