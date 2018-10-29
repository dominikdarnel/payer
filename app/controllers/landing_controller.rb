class LandingController < ApplicationController
  def index
    @accounts = Account.accessible_by(current_ability).map do |account|
      Presenters::Account.new(account)
    end
    @cards = Card.accessible_by(current_ability).map do |card|
      Presenters::Card.new(card)
    end
  end
end
