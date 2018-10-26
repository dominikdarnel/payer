require 'rails_helper'

describe Services::FundsCreator do
  subject do
    described_class.new(
      params
    )
  end

  describe 'transfer funds from card to account' do
    context 'successfull transfer' do
      let(:user) { create(:user) }
      let(:account) { create(:account, user: user, amount: 0) }
      let(:card) { create(:card, user: user, amount: 100) }
      let(:amount) { 50 }
      let(:params) do
        {
          account_id: account.id,
          card_id: card.id,
          amount: amount
        }
      end

      before(:each) do
        subject.save
      end

      it { expect(Account.first.amount).to eq(50) }
      it { expect(Card.first.amount).to eq(50) }
    end

    context 'transfer not successful' do
      context 'card has no funds' do
        let(:user) { create(:user) }
        let(:account) { create(:account, user: user, amount: 0) }
        let(:card) { create(:card, user: user, amount: 0) }
        let(:amount) { 50 }
        let(:params) do
          {
            account_id: account.id,
            card_id: card.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(0) }
        it { expect(Card.first.amount).to eq(0) }
      end

      context 'card does not have enough funds' do
        let(:user) { create(:user) }
        let(:account) { create(:account, user: user, amount: 0) }
        let(:card) { create(:card, user: user, amount: 40) }
        let(:amount) { 50 }
        let(:params) do
          {
            account_id: account.id,
            card_id: card.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(0) }
        it { expect(Card.first.amount).to eq(40) }
      end

      context 'card and account are using different currencies' do
        let(:user) { create(:user) }
        let(:currency) { Value::Currency.codes.first }
        let(:other_currency) { Value::Currency.codes.last }
        let(:account) { create(:account, user: user, amount: 0, currency: currency) }
        let(:card) { create(:card, user: user, amount: 100, currency: other_currency) }
        let(:amount) { 50 }
        let(:params) do
          {
            account_id: account.id,
            card_id: card.id,
            amount: amount
          }
        end

        before(:each) do
          subject.save
        end

        it { expect(subject.save).to be false }
        it { expect(Account.first.amount).to eq(0) }
        it { expect(Card.first.amount).to eq(100) }
      end

      context 'card and owner has differen owners' do
        context 'card and account are using different currencies' do
          let(:user) { create(:user) }
          let(:other_user) { create(:user) }
          let(:account) { create(:account, user: user, amount: 0) }
          let(:card) { create(:card, user: other_user, amount: 100) }
          let(:amount) { 50 }
          let(:params) do
            {
              account_id: account.id,
              card_id: card.id,
              amount: amount
            }
          end

          before(:each) do
            subject.save
          end

          it { expect(subject.save).to be false }
          it { expect(Account.first.amount).to eq(0) }
          it { expect(Card.first.amount).to eq(100) }
        end
      end
    end
  end
end
