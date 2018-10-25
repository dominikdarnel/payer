require 'rails_helper'

describe Card, type: :model do
  subject { described_class.new }

  it 'has a valid factory' do
    expect(build(:card)).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'valid with right attributes' do
      subject.bank = 'My little account'
      subject.currency = Value::Currency.new.code
      subject.number = 1652417783524377
      subject.month = 2
      subject.year = 19
      subject.ccv = 123
      subject.amount = 213
      subject.user = build(:user)
      expect(subject).to be_valid
    end

    context '#user' do
      it { should validate_presence_of(:user) }
    end

    context '#month' do
      it { should validate_presence_of(:month) }
      it { should validate_inclusion_of(:month).in_range(1..12) }
    end

    context '#year' do
      it { should validate_presence_of(:year) }
      it { should validate_inclusion_of(:year).in_range(18..27) }
    end

    context '#number' do
      it { should validate_presence_of(:number) }
    end

    context '#ccv' do
      it { should validate_presence_of(:ccv) }
    end

    context '#amount' do
      it { should validate_presence_of(:amount) }
      it { should allow_values(1, 100, 1000).for(:amount) }
      it { should_not allow_values(-1).for(:amount) }
    end

    context '#bank' do
      it { should validate_presence_of(:bank) }
    end

    context '#currency' do
      it { should validate_presence_of(:currency) }
      it { should allow_values(Value::Currency.codes.sample).for(:currency) }
      it { should_not allow_values('foo', '', nil).for(:currency) }
    end
  end
end
