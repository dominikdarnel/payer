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

  describe '#my_accounts' do
    let!(:user) { create(:user) }
    let!(:user_other) { create(:user) }
    let!(:account_one) { create(:account, user: user, currency: Value::Currency.codes.first) }
    let!(:account_two) { create(:account, user: user_other, currency: Value::Currency.codes.last) }

    it { expect(subject.my_accounts).to match_array([account_one]) }
  end
end
