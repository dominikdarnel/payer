require 'delegate'

module Presenters
  class Account < SimpleDelegator
    def currencies_for_select
      Value::Currency.all.collect do |currency|
        [currency.last[:text], currency.last[:code]]
      end
    end

    def selected_currency
      currency || Value::Currency.new.code
    end

    def displayed_currency
      case currency
      when Constants::CURRENCIES[:usd][:code]
        '$'
      when Constants::CURRENCIES[:eur][:code]
        '€'
      when Constants::CURRENCIES[:huf][:code]
        'HUF'
      end
    end
  end
end
