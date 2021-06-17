class CreditCardsController < ApplicationController

  def new
    @credit_card = CreditCard.new
    @previous_url = request.referrer
    @credit_cards = CreditCard.where(user_id: current_user.id)
    # @credit_cards = CreditCard.all.sort_by { |event| [event.name] }.select do |credit_card|
    #   credit_card.user == current_user
    # end
  end

  def create
    @credit_card = CreditCard.new(credit_cards_params)
    @credit_card.user = current_user
    if @credit_card.save && params[:credit_card][:previous_url].include?('payments/new')
      redirect_to new_payment_path, notice: 'Cartão de Crédito Adicionado.'
    elsif @credit_card.save
      redirect_to root_path, notice: 'Cartão de Crédito Adicionado.'
    else
      render :new
    end
  end

  def edit
    @credit_card = CreditCard.find(params[:id])
    # statement
  end

  def update
    @credit_card = CreditCard.find(params[:id])
    unless @credit_card.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    if @credit_card.update(credit_cards_params)
      redirect_to new_credit_card_path, notice: 'Cartão de Crédito Atualizado!'
    else
      render :edit
    end
  end

  def show
    @credit_card = CreditCard.find(params[:id])
    @payment = Payment.where(credit_card_id: @credit_card).last
    unless @credit_card.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    statement
  end

  def destroy
  end

  private

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

  def credit_cards_params
    params.require(:credit_card).permit(:name, :due_day, :best_day)
  end
end
