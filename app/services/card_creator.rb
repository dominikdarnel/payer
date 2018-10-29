require 'faker'

module Services
  class CardCreator
    attr_reader :card

    def initialize(card, params, current_user)
      @card = card
      @params = params
      @current_user = current_user
    end

    def save
      create_card!
      if card_is_valid?
        @card.save
        Rails.logger.info '[CardCreator] Card is successfully created.'
        true
      else
        Rails.logger.error "[CardCreator] Card could not be created: #{@card.errors.full_messages}."
        false
      end
    end

    private

    def create_card!
      @card.tap do |card|
        card.bank = fetch_bank
        card.currency = fetch_currency
        card.number = @params[:number]
        card.month = @params[:month]
        card.year = @params[:year]
        card.ccv = @params[:ccv]
        card.amount = fetch_amount
        card.user_id = @current_user.id
      end
    end

    def fetch_bank
      Faker::Bank.name
    end

    def fetch_currency
      @currency ||= Value::Currency.codes.sample
    end

    def fetch_amount
      case fetch_currency
      when Constants::CURRENCIES[:usd][:code]
        Random.rand(100..1000)
      when Constants::CURRENCIES[:eur][:code]
        Random.rand(100..1000)
      when Constants::CURRENCIES[:huf][:code]
        Random.rand(50_000..100_000)
      end
    end

    def card_is_valid?
      @card.valid?
    end
  end
end
