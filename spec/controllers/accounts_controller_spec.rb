require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
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

  describe 'GET #edit' do
    let(:account) { create(:account, user: user) }

    it 'returns http success' do
      get :edit, params: { id: account.id }, xhr: true
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { account: attributes_for(:account) } }

      it 'creates a new card' do
        expect { post :create, params: params }.to change(Account, :count).by(1)
      end

      it 'redirects_to index' do
        post :create, params: params
        expect(response).to redirect_to(accounts_path)
        expect(response.status).to eq(302)
      end
    end
    context 'with invalid params' do
      let(:params) { { account: attributes_for(:account, :invalid) } }

      it 'redirects_to index' do
        post :create, params: params
        expect(response).to redirect_to(accounts_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'POST #update' do
    context 'with valid params' do
      let(:account) { create(:account, user: user) }
      let(:params) do
        {
          id: account.id,
          account: {
            name: 'My new account name'
          }
        }
      end

      it 'redirects_to index' do
        post :update, params: params
        expect(response).to redirect_to(accounts_path)
        expect(response.status).to eq(302)
      end
    end
    context 'with invalid params' do
      let(:account) { create(:account, user: user) }
      let(:params) do
        {
          id: account.id,
          account: {
            name: nil
          }
        }
      end

      it 'redirects_to index' do
        post :create, params: params
        expect(response).to redirect_to(accounts_path)
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:account) { create(:account, user: user) }

    it 'redirects_to index' do
      delete :destroy, params: account.attributes
      expect { Card.find(account.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(accounts_path)
      expect(response.status).to eq(302)
    end
  end
end
