require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { card: attributes_for(:card) } }

      it 'creates a new card' do
        expect { post :create, params: params }.to change(Card, :count).by(1)
      end

      it 'redirects_to index' do
        post :create, params: params
        expect(response).to redirect_to(cards_path)
        expect(response.status).to eq(302)
      end
    end
    context 'with invalid params' do
      let(:params) { { card: attributes_for(:card, :invalid) } }

      it 'redirects_to index' do
        post :create, params: params
        expect(response).to redirect_to(cards_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:card) { create(:card, user: user) }

    it 'redirects_to index' do
      delete :destroy, params: card.attributes
      expect { Card.find(card.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(cards_path)
      expect(response.status).to eq(302)
    end
  end
end
