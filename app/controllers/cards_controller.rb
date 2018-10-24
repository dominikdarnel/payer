class CardsController < ApplicationController
  before_action :set_card, only: :destroy

  def index
    @cards = Card.all.map do |card|
      Presenters::Card.new(card)
    end
  end

  def new
    @card = Presenters::Card.new(Card.new)
    respond_to do |format|
      format.js
    end
  end

  def create
    @card_service = Services::CardCreator.new(Card.new, card_params, current_user)
    @card = @card_service.card
    respond_to do |format|
      if @card_service.save
        format.html { redirect_to cards_path, notice: 'Card was successfully created.' }
        format.json { render :index, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:number, :month, :year, :ccv)
  end
end
