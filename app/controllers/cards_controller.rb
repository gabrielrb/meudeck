class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.user = current_user
    if @card.save
      redirect_to card_path(@card), notice: "card was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to card_path(@card), notice: "card was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path, notice: "card was successfully deleted"
  end
end

private

def set_card
  @card = Card.find(params[:id])
end

def card_params
  params.require(:card).permit(:category, :name, :description, :price)
end
