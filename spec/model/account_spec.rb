require 'rails_helper'

describe Account, type: :model do
  subject { described_class.new }

  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  describe 'Associations' do
    it { should have_many(:cards) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'valid with right attributes' do
      subject.name = 'My little account'
      subject.currency = Value::Currency.new.code
      subject.user = build(:user)
      expect(subject).to be_valid
    end

    it 'not valid without a name' do
      subject.name = nil
      subject.currency = Value::Currency.new.code
      subject.user = build(:user)
      expect(subject).not_to be_valid
    end

    it 'not valid without a currency' do
      subject.name = 'My little account'
      subject.currency = nil
      subject.user = build(:user)
      expect(subject).not_to be_valid
    end

    it 'not valid without a valid currency' do
      subject.name = 'My little account'
      subject.currency = 'GBP'
      subject.user = build(:user)
      expect(subject).not_to be_valid
    end

    it 'not valid without a name' do
      subject.name = 'My little account'
      subject.currency = Value::Currency.new.code
      subject.user = nil
      expect(subject).not_to be_valid
    end
  end
end
