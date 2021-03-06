require 'rails_helper'

describe Presenters::Card do
  let(:card) { build(:card) }
  subject { described_class.new(card) }

  describe '#months_for_select' do
    let(:allowed_months) { (1..12).to_a }
    it { expect(subject.months_for_select).to match_array(allowed_months) }
  end

  describe '#selected_month' do
    context 'account has month' do
      it { expect(subject.selected_month).to eq card.month }
    end

    context 'default value for new card' do
      let(:card) { build(:card, month: nil) }
      it { expect(subject.selected_month).to eq 1 }
    end
  end

  describe '#years_for_select' do
    let(:allowed_years) { (18..27).to_a }
    it { expect(subject.years_for_select).to match_array(allowed_years) }
  end

  describe '#selected_year' do
    context 'account has year' do
      it { expect(subject.selected_year).to eq card.year }
    end

    context 'default value for new card' do
      let(:card) { build(:card, year: nil) }
      it { expect(subject.selected_year).to eq 18 }
    end
  end

  describe '#number_display' do
    let(:card) { build(:card, number: 6352948857341533) }
    let(:result) { 'XXXX-XXXX-XXXX-1533' }
    it { expect(subject.number_display).to eq result }
  end
end
