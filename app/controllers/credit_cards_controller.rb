class CreditCardsController < ApplicationController
  def new
    @credit_cards = CreditCard.all.sort_by { |event| [event.name] }.select do |credit_card|
      credit_card.user == current_user
    end
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = CreditCard.new(credit_cards_params)
    @credit_card.user = current_user
    @credit_card.name = params[:credit_card][:name].titleize
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

  def destroy
  end

  private

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end
end
