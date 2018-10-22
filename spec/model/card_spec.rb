require 'rails_helper'

describe Card, type: :model do
  it "has a valid factory" do
    skip
  end
  describe 'Associations' do
    it { should belong_to(:account) }
  end
end
