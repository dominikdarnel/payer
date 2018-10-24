class LandingController < ApplicationController
  def index
    @accounts = Account.all.map do |account|
      Presenters::Account.new(account)
    end
    @cards = Card.all.map do |card|
      Presenters::Card.new(card)
    end
  end
end
