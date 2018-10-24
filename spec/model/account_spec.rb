require 'rails_helper'

describe Account, type: :model do
  subject { described_class.new }

  it "has a valid factory" do
    expect(build(:account)).to be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'valid with right attributes' do
      subject.name = 'My little account'
      subject.currency = Value::Currency.new.code
      subject.user = build(:user)
      expect(subject).to be_valid
    end

    context '#name' do
      it { should validate_presence_of(:name) }
    end

    context '#user' do
      it { should validate_presence_of(:user) }
    end

    context '#currency' do
      it { should validate_presence_of(:currency) }
      it { should allow_values(Value::Currency.codes.sample).for(:currency) }
      it { should_not allow_values('foo', '', nil).for(:currency) }
    end
  end
end
