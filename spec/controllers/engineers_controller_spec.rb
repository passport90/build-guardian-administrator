require 'rails_helper'

describe EngineersController, type: :controller do
  describe "GET #index" do
    it "return ok when accessing engineers index page" do
      engineers = Engineer.all
      get :index, session: {
        authenticated: true
      }

      expect(response).to have_http_status(200)
      expect(assigns(:engineers)).to eq engineers
    end

    it "redirect to home when user not authenticated" do
      engineers = Engineer.all
      get :index, session: {
        authenticated: false
      }

      expect(response.location).to eq "http://test.host/"
    end
  end

  describe "GET #new" do
    it "return ok when accessing engineers new page" do
      get :new, session: {
        authenticated: true
      }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    let(:engineer) { build :engineer }
    it "success creating new engineer" do
      expected_count = Engineer.count + 1
      attributes = engineer.attributes
      post :create, params: {
        engineer: attributes
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expect(Engineer.count).to eq expected_count
    end

    it "should not create engineer if slack username exists" do
      attributes = engineer.attributes
      post :create, params: {
        engineer: attributes
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expected_count = Engineer.count
      post :create, params: {
        engineer: attributes
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expect(Engineer.count).to eq expected_count
    end
  end

  describe "GET #edit" do
    let(:engineer) { create :engineer }
    it "return ok when accessing existing engineer page" do
      id = engineer.id
      get :edit, params: {
        id: id
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(200)
      expect(assigns(:engineer)).to eq engineer
    end

    it "redirects to index when user not found" do
      get :edit, params: {
        id: 999
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expect(response.location).to eq "http://test.host/engineers"
    end
  end

  describe "PUT #update" do
    let(:engineer) { create :engineer }
    it "update slack_username" do
      attributes = engineer.attributes
      attributes["slack_username"] = "foo"
      put :update, params: {
        id: engineer.id,
        engineer: attributes
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expect(Engineer.first.slack_username).to eq "foo"
    end

    it "redirect to home when try to update unexist id" do
      attributes = engineer.attributes
      attributes["slack_username"] = "foo"
      put :update, params: {
        id: 999,
        engineer: attributes
      }, session: {
        authenticated: true
      }
      expect(response).to have_http_status(302)
      expect(response.location).to eq "http://test.host/engineers"
    end
  end

  describe "DELETE #destroy" do
    let!(:engineer) { create :engineer }
    it "delete existing engineer" do
      attributes = engineer.attributes
      before_count = Engineer.count
      delete :destroy, params: {
        id: engineer.id,
      }, session: {
        authenticated: true
      }
      expect(Engineer.count).to eq before_count - 1
    end

    it "redirect to home when try to update unexist id" do
      before_count = Engineer.count
      delete :destroy, params: {
        id: 999,
      }, session: {
        authenticated: true
      }
      expect(Engineer.count).to eq before_count
    end
  end

end
