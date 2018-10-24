class CardsController < ApplicationController
  before_action :set_card, only: :destroy

  def index
    @cards = Card.all
  end

  def new
    @card = Presenters::Card(Card.new)
  end

  def create
    @card_service = Services::CardCreator(Card.new, card_params, current_user)
    @card = @card_service.card
    respond_to do |format|
      if @card_service.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
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
    params.require(:card).permit(:bank, :name, :number, :month, :year, :ccv)
  end
end
