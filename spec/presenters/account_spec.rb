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
      it { expect(described_class.new(new_account).selected_currency).to eq 'USD' }
    end
  end

  describe 'displayed_currency' do
    context 'USD' do
      let(:usd_account) do
        build(:account, currency: Constants::CURRENCIES[:usd][:code])
        it 'return dollar sign' do
          expect(described_class.new(new_account).displayed_currency).to eq '$'
        end
      end
    end
    context 'EUR' do
      let(:usd_account) do
        build(:account, currency: Constants::CURRENCIES[:eur][:code])
        it 'return euro sign' do
          expect(described_class.new(new_account).displayed_currency).to eq '€'
        end
      end
    end
    context 'HUF' do
      let(:usd_account) do
        build(:account, currency: Constants::CURRENCIES[:huf][:code])
        it 'return huf text' do
          expect(described_class.new(new_account).displayed_currency).to eq 'HUF'
        end
      end
    end
  end
end
