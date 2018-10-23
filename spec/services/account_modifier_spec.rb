require 'rails_helper'

describe Services::AccountModifier do
  subject do
    described_class.new(
      account,
      params,
      user
    )
  end

  describe 'create a new account' do
    let(:account) { Account.new }
    let(:user) { create(:user) }
    let(:params) do
      {
        name: 'My test account',
        currency: Value::Currency.new.code
      }
    end

    it 'creates a new account in the database' do
      expect { subject.save }.to change(Account, :count).by(1)
    end

    it 'has the right attributes' do
      subject.save
      expect(subject.account.name).to eq params[:name]
      expect(subject.account.currency).to eq params[:currency]
      expect(subject.account.user).to eq user
      expect(subject.account.amount).to eq 0
    end
  end

  describe 'updates an account' do
    let(:account) { create(:account, user: user) }
    let(:user) { create(:user) }
    let(:params) do
      {
        name: 'My test account'
      }
    end
    it 'updates account name' do
      subject.save
      expect(subject.account.name).to eq params[:name]
    end
  end
end
