class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[edit update destroy]

  def new
    @credit_card = CreditCard.new
  end

  def index
    @credit_card = CreditCard.new
    @credit_cards = CreditCard.where(user_id: current_user.id, status: true).sort_by { |event| [event.name] }
  end

  def create
    @credit_card = CreditCard.new(credit_cards_params)
    @credit_card.user = current_user
    redirect_to credit_cards_path if @credit_card.save
  end

  def edit
  end

  def update
    unless @credit_card.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    if @credit_card.update(credit_cards_params)
      redirect_to credit_cards_path, notice: 'Cartão de Crédito Atualizado!'
    end
  end

  def destroy
    unless @credit_card.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    @credit_card.update(status: false)
    redirect_to credit_cards_path, notice: 'Cartão de Crédito Apagado!'
  end

  private

  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  end

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end

  def statement
    @payments_january = Payment.where(credit_card_id: @payment.credit_card_id,
                                      year_date: Date.today.year,
                                      month_date: 1,
                                      partial: 1).sort_by { |event| [event.date] }
    @payments_february = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: Date.today.year,
                                       month_date: 2,
                                       partial: 1).sort_by { |event| [event.date] }
    @payments_march = Payment.where(credit_card_id: @payment.credit_card_id,
                                    year_date: Date.today.year,
                                    month_date: 3,
                                    partial: 1).sort_by { |event| [event.date] }
    @payments_april = Payment.where(credit_card_id: @payment.credit_card_id,
                                    year_date: Date.today.year,
                                    month_date: 4,
                                    partial: 1).sort_by { |event| [event.date] }
    @payments_may = Payment.where(credit_card_id: @payment.credit_card_id,
                                  year_date: Date.today.year,
                                  month_date: 5,
                                  partial: 1).sort_by { |event| [event.date] }
    @payments_june = Payment.where(credit_card_id: @payment.credit_card_id,
                                   year_date: Date.today.year,
                                   month_date: 6,
                                   partial: 1).sort_by { |event| [event.date] }
    @payments_july = Payment.where(credit_card_id: @payment.credit_card_id,
                                   year_date: Date.today.year,
                                   month_date: 7,
                                   partial: 1).sort_by { |event| [event.date] }
    @payments_august = Payment.where(credit_card_id: @payment.credit_card_id,
                                     year_date: Date.today.year,
                                     month_date: 8,
                                     partial: 1).sort_by { |event| [event.date] }
    @payments_september = Payment.where(credit_card_id: @payment.credit_card_id,
                                        year_date: Date.today.year,
                                        month_date: 9,
                                        partial: 1).sort_by { |event| [event.date] }
    @payments_october = Payment.where(credit_card_id: @payment.credit_card_id,
                                      year_date: Date.today.year,
                                      month_date: 10,
                                      partial: 1).sort_by { |event| [event.date] }
    @payments_november = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: Date.today.year,
                                       month_date: 11,
                                       partial: 1).sort_by { |event| [event.date] }
    @payments_december = Payment.where(credit_card_id: @payment.credit_card_id,
                                       year_date: "2020",
                                       month_date: 12,
                                       partial: 1).sort_by { |event| [event.date] }
  end

end
