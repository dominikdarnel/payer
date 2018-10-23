require 'rails_helper'

describe Value::Currency do
  subject { described_class }

  describe 'default currency' do
    let(:default_currency) { Constants::CURRENCIES[:usd] }
    it { expect(subject.new.currency).to eq default_currency }
  end

  describe '#text' do
    it 'should return currency text' do
      expect(subject.new.text).to eq 'US Dollar'
    end
  end

  describe '#code' do
    it 'should return currency code' do
      expect(subject.new.code).to eq 'USD'
    end
  end

  describe '#all' do
    it { expect(subject.all).to eq Constants::CURRENCIES }
  end

  describe '#codes' do
    it 'should return currency codes' do
      expect(subject.codes).to eq %w[HUF USD EUR]
    end
  end
end
