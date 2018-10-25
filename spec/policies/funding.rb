require 'rails_helper'

describe Policies::Funding do
  subject do
    described_class.new(
      account,
      card,
      amount
    )
  end

  let(:card) { create(:card) }
  let(:account) { create(:account) }
  let(:amount) { 100 }

  describe '#card_has_funds?' do
    context 'card has funds' do
      it { expect(subject.card_has_funds?).to be true }
    end

    context 'card has no funds' do
      let(:card) { create(:card, amount: 0) }

      it { expect(subject.card_has_funds?).to be false }
    end
  end

  describe '#card_has_same_currency_as_account?' do
    let(:currency) { Value::Currency.codes.first }
    let(:other_currency) { Value::Currency.codes.last }

    context 'card and account has the same currency' do
      let(:card) { create(:card, currency: currency) }
      let(:account) { create(:card, currency: currency) }

      it { expect(subject.card_has_same_currency_as_account?).to be true }
    end

    context 'card and account does not have the same currency' do
      let(:card) { create(:card, currency: currency) }
      let(:account) { create(:card, currency: other_currency) }

      it { expect(subject.card_has_same_currency_as_account?).to be false }
    end
  end

  describe '#card_has_enough_funds?' do
    let(:amount) { 100 }

    context 'card has enough funds' do
      let(:card) { create(:card, amount: 200) }

      it { expect(subject.card_has_enough_funds?).to be true }
    end

    context 'card does not have enough funds' do
      let(:card) { create(:card, amount: 50) }

      it { expect(subject.card_has_enough_funds?).to be false }
    end
  end

  describe '#card_and_account_has_same_owner?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'card and account has the same owner' do
      let(:card) { create(:card, user: user) }
      let(:account) { create(:account, user: user) }

      it { expect(subject.card_and_account_has_same_owner?).to be true }
    end

    context 'card and account does not have the same owner' do
      let(:card) { create(:card, user: user) }
      let(:account) { create(:account, user: other_user) }

      it { expect(subject.card_and_account_has_same_owner?).to be false }
    end
  end
end
