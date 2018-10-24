class LandingController < ApplicationController
  def index
    @accounts = Account.all.map do |account|
      Presenters::Account.new(account)
    end
  end
end
