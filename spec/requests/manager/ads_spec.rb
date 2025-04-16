require 'rails_helper'

RSpec.describe "Manager::Ads", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/manager/ads/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/manager/ads/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/manager/ads/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/manager/ads/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
