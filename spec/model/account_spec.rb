require 'rails_helper'

describe Account, type: :model do
  it "has a valid factory" do
    skip
  end
  describe 'Associations' do
    it { should have_many(:cards) }
    it { should belong_to(:user) }
  end
end
