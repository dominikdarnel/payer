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

    def self.codes
      Constants::CURRENCIES.map do |currency|
        currency.last[:code]
      end
    end

    def self.texts
      Constants::CURRENCIES.map do |currency|
        currency.last[:text]
      end
    end
  end
end
