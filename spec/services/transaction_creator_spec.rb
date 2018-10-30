require 'rails_helper'

describe Services::TransactionCreator do
  subject do
    described_class.new(
      params,
      user
    )
  end

  describe 'transfer funds from one users account to anothers' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'successfull transfer' do
      let(:from_account) { create(:account, user: user, amount: 100) }
      let(:to_account) { create(:account, user: other_user, amount: 100) }
      let(:amount) { 50 }
      let(:params) do
        {
          from_account_id: from_account.id,
          to_account_id: to_account.id,
          to_user_id: other_user.id,
          amount: amount
        }
      end

      before(:each) do
        subject.save
      end

      it { expect(Account.first.amount).to eq(50) }
      it { expect(Account.last.amount).to eq(150) }
    end

    context 'transfer not successful' do
      context 'from account has no funds' do
        let(:from_account) { create(:account, user: user, amount: 0) }
        let(:to_account) { create(:account, user: other_user, amount: 100) }
        let(:amount) { 50 }
        let(:params) do
          {
            from_account_id: from_account.id,
            to_account_id: to_account.id,
            to_user_id: other_user.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(0) }
        it { expect(Account.last.amount).to eq(100) }
      end

      context 'from account does not have enough funds' do
        let(:from_account) { create(:account, user: user, amount: 40) }
        let(:to_account) { create(:account, user: other_user, amount: 100) }
        let(:amount) { 50 }
        let(:params) do
          {
            from_account_id: from_account.id,
            to_account_id: to_account.id,
            to_user_id: other_user.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(40) }
        it { expect(Account.last.amount).to eq(100) }
      end

      context 'accounts are using different currencies' do
        let(:currency) { Value::Currency.codes.first }
        let(:other_currency) { Value::Currency.codes.last }
        let(:from_account) { create(:account, user: user, amount: 50, currency: currency) }
        let(:to_account) { create(:account, user: other_user, amount: 100, currency: other_currency) }
        let(:amount) { 50 }
        let(:params) do
          {
            from_account_id: from_account.id,
            to_account_id: to_account.id,
            to_user_id: other_user.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(50) }
        it { expect(Account.last.amount).to eq(100) }
      end

      context 'both account has the same owners' do
        let(:from_account) { create(:account, user: user, amount: 40) }
        let(:to_account) { create(:account, user: user, amount: 100) }
        let(:amount) { 50 }
        let(:params) do
          {
            from_account_id: from_account.id,
            to_account_id: to_account.id,
            to_user_id: other_user.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(40) }
        it { expect(Account.last.amount).to eq(100) }
      end
    end
  end
end
