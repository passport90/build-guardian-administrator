require "rails_helper"

describe MainController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #select" do
    it "responds successfully with an HTTP 302 status code" do
      post :select
      expect(response).to have_http_status(302)
    end
  end

  describe "POST #conclude" do
    it "responds successfully with an HTTP 302 status code" do
      post :conclude
      expect(response).to have_http_status(302)
    end
  end
end
