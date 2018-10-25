class CardsController < ApplicationController
  before_action :set_card, only: :destroy
  load_and_authorize_resource

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
    respond_to do |format|
      if @card_service.save
        format.html { redirect_to cards_path, flash: { success: 'Card was successfully created' } }
        format.json { render :index, status: :created, location: @card }
      else
        format.html { redirect_to cards_path, flash: { error: 'Card could not be created due to errors!' } }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, flash: { success: 'Card was successfully destroyed.' } }
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
