require 'rails_helper'

describe Presenters::Funds do
  subject { described_class.new(user) }

  describe '#cards_for_account' do
    let!(:user) { create(:user) }
    let!(:account) { create(:account, user: user, currency: Value::Currency.codes.first) }
    let!(:card_one) { create(:card, user: user, currency: Value::Currency.codes.first) }
    let!(:card_two) { create(:card, user: user, currency: Value::Currency.codes.last) }

    it { expect(subject.cards_for_account(account)).to match_array([card_one]) }
  end

  describe '#cards_for_account_json' do
    let!(:user) { create(:user) }
    let!(:account) { create(:account, user: user, currency: Value::Currency.codes.first) }
    let!(:card_one) { create(:card, user: user, currency: Value::Currency.codes.first) }
    let!(:card_two) { create(:card, user: user, currency: Value::Currency.codes.last) }
    let(:result) do
      {
        text: Presenters::Card.new(card_one).number_display,
        id: card_one.id
      }
    end

    it { expect(subject.cards_for_account_json(account)).to match_array([result]) }
  end

  describe '#my_accounts' do
    let!(:user) { create(:user) }
    let!(:user_other) { create(:user) }
    let!(:account_one) { create(:account, user: user, currency: Value::Currency.codes.first) }
    let!(:account_two) { create(:account, user: user_other, currency: Value::Currency.codes.last) }

    it { expect(subject.my_accounts).to match_array([account_one]) }
  end

  describe '#my_accounts_for_select' do
    let!(:user) { create(:user) }
    let!(:user_other) { create(:user) }
    let!(:account_one) { create(:account, user: user, currency: Value::Currency.codes.first) }
    let!(:account_two) { create(:account, user: user_other, currency: Value::Currency.codes.last) }

    it { expect(subject.my_accounts_for_select).to match_array([[account_one.name, account_one.id]]) }
  end
end
