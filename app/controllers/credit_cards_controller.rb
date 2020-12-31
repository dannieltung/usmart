class CreditCardsController < ApplicationController
  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_cards_params)
    @credit_card.user = current_user
    if @credit_card.save
      redirect_to root_path, notice: 'Credit Card created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def index
  end

  def destroy
  end

  private

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end
end
