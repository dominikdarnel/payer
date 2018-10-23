require 'rails_helper'

describe Value::Currency do
  subject { described_class.new }
  describe 'default currency' do
    let(:default_currency) { Constants::CURRENCIES[:usd] }
    it { expect(subject.currency).to eq default_currency }
  end
  describe '#text' do
    it 'should return currency text' do
      expect(subject.text).to eq 'US Dollar'
    end
  end
  describe '#code' do
    it 'should return currency code' do
      expect(subject.code).to eq 'USD'
    end
  end
end
