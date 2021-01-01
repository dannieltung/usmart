class PaymentsController < ApplicationController
  def create
    partial = 1
    params[:payment][:total_partial].to_i.times do
      @payment = Payment.new(payments_params)
      @payment.user = current_user
      @payment.partial = partial
      Date.parse(params[:payment][:date]) >= Date.today.change(day: CreditCard.find(params[:payment][:credit_card_id]).best_day) ? @payment.due_date = (Date.today + (partial + 1).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day) : @payment.due_date = (Date.today + partial.month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      @payment.save
      partial += 1
    end
    if @payment.save
      redirect_to root_path, notice: 'Payment created!'
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

  def payments_params
    params.require(:payment).permit(:amount,
                                    :date,
                                    :due_date,
                                    :partial,
                                    :total_partial,
                                    :description,
                                    :user_id,
                                    :credit_card_id,
                                    :buyer_id,
                                    :category_id)
  end
end
