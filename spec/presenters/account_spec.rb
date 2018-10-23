require 'rails_helper'

describe Presenters::Account do
  subject { described_class.new(build(:account)) }
  describe '#currencies_for_select' do
    let(:result) do
      [
        ['Hungarian Forint', 'HUF'],
        ['US Dollar', 'USD'],
        ['Euro', 'EUR']
      ]
    end
    it { expect(subject.currencies_for_select).to eq result }
  end

  describe '#selected_currency' do
    context 'account has currency' do
      it { expect(subject.selected_currency).to eq 'USD' }
    end

    context 'default value for new accounts' do
      let(:new_account) { build(:account, currency: nil) }
      it { expect(subject.selected_currency).to eq 'USD' }
    end
  end
end