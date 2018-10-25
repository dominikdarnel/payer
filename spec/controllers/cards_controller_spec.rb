require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, params: { card: attributes_for(:card) }
      expect(response).to redirect_to(cards_path)
      expect(response.status).to eq(302)
    end
  end

  describe "DELETE #destroy" do
    let(:card) { create(:card, user: user) }
    it "returns http success" do
      delete :destroy, params: card.attributes
      expect(response).to redirect_to(cards_path)
      expect(response.status).to eq(302)
    end
  end
end
