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
    @payment = Payment.find(params[:id])
    @credit_card = CreditCard.find(@payment.credit_card_id)
    unless @credit_card.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    statement
  end

  def update
  end

  def destroy
  end

  private

  def statement
    @payments_january = Payment.where(credit_card_id: @payment.credit_card_id, partial: 1)
  end

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end
end
