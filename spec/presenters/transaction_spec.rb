require 'rails_helper'

describe Presenters::Transaction do
  subject { described_class.new(transaction) }
  let(:transaction) { create(:transaction, from_user: user) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe '#my_accounts' do
    let(:account_one) { create(:account, user: user) }
    let!(:account_two) { create(:account, user: other_user) }

    it { expect(subject.my_accounts).to match_array([account_one]) }
  end

  describe '#other_users' do
    it { expect(subject.other_users).to include(other_user) }
    it { expect(subject.other_users).not_to include(user) }
  end

  describe '#accounts_for_transaction' do
    let(:account_one) { create(:account, user: user) }
    let!(:account_two) { create(:account, user: user, currency: Value::Currency.codes.last) }
    let!(:account_three) { create(:account, user: other_user) }

    it { expect(subject.accounts_for_transaction(user, account_one)).to match_array([account_one]) }
  end

  describe '#cards_for_account_json' do
    let(:account_one) { create(:account, user: user) }
    let!(:account_two) { create(:account, user: user, currency: Value::Currency.codes.last) }
    let!(:account_three) { create(:account, user: other_user) }
    let(:result) do
      {
        text: account_one.name,
        id: account_one.id
      }
    end

    it { expect(subject.accounts_for_transaction_json(user, account_one)).to match_array([result]) }
  end
end
