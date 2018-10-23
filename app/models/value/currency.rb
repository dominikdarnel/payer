module Value
  class Currency
    attr_reader :currency
    def initialize(currency = Constants::CURRENCIES[:usd])
      @currency = currency
    end

    def text
      @currency[:text]
    end

    def code
      @currency[:code]
    end

    def self.all
      Constants::CURRENCIES
    end
  end
end
