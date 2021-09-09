class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]

  def home
    # @payments = Payment.where("due_date > ?", (Date.today - 2.week)).sort_by { |event| [event.due_date, event.date, event.amount] }.select do |payment|
    #   payment.user == current_user
    # end
    # actual_month(0, 2)
    # plus_one_month
    # # @payments = Payment.all.sort_by { |event| [event.due_date, event.date, event.amount] }.select do |payment|
    # #   payment.user == current_user
    # # end
    @payment = Payment.new
    @categories = Category.where(user_id: current_user.id).where.not(name: 'Não Definido').sort_by { |event| event.name }
    # @credit_cards = CreditCard.where(user_id: current_user.id, status: true).sort_by { |event| event.name }
    # @buyers = Buyer.where(user_id: current_user.id).sort_by { |event| event.name }
    @payments = Payment.where(user_id: current_user.id).sort_by { |event| event.due_date }
  end

  private

  def actual_month(extra_month, credit_card)
    payments = @payments.select { |k| k["month_due"] == (Date.today.month + extra_month) && k["credit_card_id"] == credit_card }
    @due_date = payments.last&.due_date
    @total_amount = 0
    payments.each do |payment|
      @total_amount += payment.amount
    end
  end

  def plus_one_month
    payments = @payments.select { |k| k["month_due"] == (Date.today.month + 1) && k["credit_card_id"] == 2 }
    @plus_one_due_date = payments.last&.due_date
    @plus_one_total_amount = 0
    payments.each do |payment|
      @plus_one_total_amount += payment.amount
    end
  end

end
