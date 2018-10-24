require 'delegate'

module Presenters
  class Card < SimpleDelegator
    def currencies_for_select
      Value::Currency.all.collect do |currency|
        [currency.last[:text], currency.last[:code]]
      end
    end

    def selected_currency
      currency || Value::Currency.new.code
    end
  end
end
