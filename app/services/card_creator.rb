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
      else
        false
      end
    end

    private

    def create_card!
      @card.tap do |card|
        card.bank = Faker::Bank.name
        card.name = @params[:name]
        card.currency = @params[:currency]
        card.number = @params[:number]
        card.month = @params[:month]
        card.year = @params[:year]
        card.ccv = @params[:ccv]
        card.amount = generate_money
        card.user_id = @current_user.id
      end
    end

    def generate_money
      case @params[:currency]
      when Constants::CURRENCIES[:usd][:code]
        Random.rand(100..1000)
      when Constants::CURRENCIES[:eur][:code]
        Random.rand(100..1000)
      when Constants::CURRENCIES[:huf][:code]
        Random.rand(10_000..100_000)
      end
    end

    def card_is_valid?
      @card.valid?
    end
  end
end
