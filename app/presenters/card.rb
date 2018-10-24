require 'delegate'

module Presenters
  class Card < SimpleDelegator
    def months_for_select
      Constants::VALID_MONTHS
    end

    def selected_month
      month || Constants::VALID_MONTHS.first
    end

    def years_for_select
      Constants::VALID_YEARS
    end

    def selected_year
      year || Constants::VALID_YEARS.first
    end

    def number_display
      last_four_digit = number.to_s.last(4)
      "XXXX-XXXX-XXXX-#{last_four_digit}"
    end
  end
end
