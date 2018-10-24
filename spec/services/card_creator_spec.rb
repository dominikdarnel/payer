require 'rails_helper'

describe Services::CardCreator do
  subject do
    described_class.new(
      card,
      params,
      user
    )
  end

  describe 'create a new card' do
    let(:card) { Card.new }
    let(:user) { create(:user) }
    let(:params) do
      {
        name: 'My test card',
        currency: Value::Currency.new.code,
        number: 1234123412341234,
        month: 12,
        year: 21,
        ccv: 123
      }
    end

    it 'creates a new account in the database' do
      expect { subject.save }.to change(Card, :count).by(1)
    end

    it 'has the right attributes' do
      subject.save
      expect(subject.card.name).to eq params[:name]
      expect(subject.card.currency).to eq params[:currency]
      expect(subject.card.bank).to be_a_kind_of(String)
      expect(subject.card.number).to eq params[:number]
      expect(subject.card.month).to eq params[:month]
      expect(subject.card.year).to eq params[:year]
      expect(subject.card.ccv).to eq params[:ccv]
      expect(subject.card.user).to eq user
      expect(subject.card.amount).to be_a_kind_of(Integer)
    end
  end
end
