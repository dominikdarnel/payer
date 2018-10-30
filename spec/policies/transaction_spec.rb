require 'rails_helper'

describe Policies::Transaction do
  subject do
    described_class.new(
      from_account,
      to_account,
      amount
    )
  end

  let(:from_account) { create(:account) }
  let(:to_account) { create(:account) }
  let(:amount) { 100 }

  describe '#from_account_has_funds?' do
    context 'from account has funds' do
      it { expect(subject.from_account_has_funds?).to be true }
    end

    context 'from account has no funds' do
      let(:from_account) { create(:account, amount: 0) }

      it { expect(subject.from_account_has_funds?).to be false }
    end
  end

  describe '#accounts_on_same_currency?' do
    let(:currency) { Value::Currency.codes.first }
    let(:other_currency) { Value::Currency.codes.last }

    context 'both account has the same currency' do
      let(:from_account) { create(:account, currency: currency) }
      let(:to_account) { create(:account, currency: currency) }

      it { expect(subject.accounts_on_same_currency?).to be true }
    end

    context 'one account has a different currency' do
      let(:from_account) { create(:account, currency: currency) }
      let(:to_account) { create(:account, currency: other_currency) }

      it { expect(subject.accounts_on_same_currency?).to be false }
    end
  end

  describe '#from_account_has_enough_funds?' do
    let(:amount) { 100 }

    context 'from account has enough funds' do
      let(:from_account) { create(:account, amount: 200) }

      it { expect(subject.from_account_has_enough_funds?).to be true }
    end

    context 'from account does not have enough funds' do
      let(:from_account) { create(:account, amount: 50) }

      it { expect(subject.from_account_has_enough_funds?).to be false }
    end
  end

  describe '#accounts_have_different_owner?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'both account has the different owner' do
      let(:from_account) { create(:account, user: user) }
      let(:to_account) { create(:account, user: other_user) }

      it { expect(subject.accounts_have_different_owner?).to be true }
    end

    context 'both account has the same owner' do
      let(:from_account) { create(:account, user: user) }
      let(:to_account) { create(:account, user: user) }

      it { expect(subject.accounts_have_different_owner?).to be false }
    end
  end
end
