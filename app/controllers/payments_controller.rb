class PaymentsController < ApplicationController
  def create
    partial = 0
    params[:payment][:total_partial].to_i.times do
      @payment = Payment.new(payments_params)
      @payment.user = current_user
      @payment.partial = partial + 1
      @payment.total_amount = params[:payment][:amount]
      @payment.amount = params[:payment][:amount].to_f / params[:payment][:total_partial].to_i
      @payment.description = params[:payment][:description].capitalize
      if case_card_1?
        @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 2).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      elsif case_card_2?
        @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 1).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      elsif case_card_3?
        @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 1).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      elsif case_card_4?
        @payment.due_date = (Date.parse(params[:payment][:date]) + partial.month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      end
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
    @payment = Payment.find(params[:id])
    unless @payment.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    @payments = Payment.where(date: @payment.date, category: @payment.category, description: @payment.description, total_partial: @payment.total_partial)
  end

  def update
  end

  def show
    @payment = Payment.find(params[:id])
    @payments = Payment.where(date: @payment.date, category: @payment.category, description: @payment.description, total_partial: @payment.total_partial)
  end

  def destroy
    @payment = Payment.find(params[:id])
    unless @payment.user == current_user
      redirect_to root_path, notice: 'Not allowed to Delete 😠'
    end
    @payments = Payment.where(date: @payment.date, category: @payment.category, description: @payment.description, total_partial: @payment.total_partial)
    @payments.destroy_all
    redirect_to root_path, notice: 'Payment destroyed!'
  end

  private

  def case_card_1?
    CreditCard.find(params[:payment][:credit_card_id]).best_day > CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) >= Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
  end

  def case_card_2?
    CreditCard.find(params[:payment][:credit_card_id]).best_day > CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) < Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
  end

  def case_card_3?
    CreditCard.find(params[:payment][:credit_card_id]).best_day < CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) >= Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
  end

  def case_card_4?
    CreditCard.find(params[:payment][:credit_card_id]).best_day < CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) < Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
  end

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
                                    :category_id,
                                    :total_amount)
  end
end
