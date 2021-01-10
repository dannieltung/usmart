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
    @payments_january = Payment.where(credit_card_id: @payment.credit_card_id,
                                      year_date: Date.today.year,
                                      month_date: 1,
                                      partial: 1)
    @payments_february = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: Date.today.year,
                                       month_date: 2,
                                       partial: 1)
    @payments_march = Payment.where(credit_card_id: @payment.credit_card_id,
                                    year_date: Date.today.year,
                                    month_date: 3,
                                    partial: 1)
    @payments_april = Payment.where(credit_card_id: @payment.credit_card_id,
                                    year_date: Date.today.year,
                                    month_date: 4,
                                    partial: 1)
    @payments_may = Payment.where(credit_card_id: @payment.credit_card_id,
                                  year_date: Date.today.year,
                                  month_date: 5,
                                  partial: 1)
    @payments_june = Payment.where(credit_card_id: @payment.credit_card_id,
                                   year_date: Date.today.year,
                                   month_date: 6,
                                   partial: 1)
    @payments_july = Payment.where(credit_card_id: @payment.credit_card_id,
                                   year_date: Date.today.year,
                                   month_date: 7,
                                   partial: 1)
    @payments_august = Payment.where(credit_card_id: @payment.credit_card_id,
                                     year_date: Date.today.year,
                                     month_date: 8,
                                     partial: 1)
    @payments_september = Payment.where(credit_card_id: @payment.credit_card_id,
                                        year_date: Date.today.year,
                                        month_date: 9,
                                        partial: 1)
    @payments_october = Payment.where(credit_card_id: @payment.credit_card_id,
                                      year_date: Date.today.year,
                                      month_date: 10,
                                      partial: 1)
    @payments_november = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: Date.today.year,
                                       month_date: 11,
                                       partial: 1)
    @payments_december = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: "2020",
                                       month_date: 12,
                                       partial: 1)
  end

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end
end
