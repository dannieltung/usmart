class PaymentsController < ApplicationController
  def create
    flag = rand(1..100)
    partial = 0
    params[:payment][:total_partial].to_i.times do
      @payment = Payment.new(payments_params)
      @payment.user = current_user
      @payment.partial = partial + 1
      @payment.total_amount = params[:payment][:amount]
      @payment.amount = params[:payment][:amount].to_f / params[:payment][:total_partial].to_i
      @payment.description = params[:payment][:description].titleize
      due_date(partial)
      @payment.month_due = @payment.due_date.month
      @payment.month_date = @payment.date.month
      @payment.year_date = @payment.date.year
      @payment.flag = flag
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

  def show
    @payment = Payment.find(params[:id])
    @payments = Payment.where(flag: @payment.flag, date: @payment.date, description: @payment.description, total_partial: @payment.total_partial).sort_by { |event| [event.due_date] }
  end

  def update
    @single_partial = Payment.find(params[:id])
    @payment = Payment.where(flag: @single_partial.flag, date: @single_partial.date, total_partial: @single_partial.total_partial, total_amount: @single_partial.total_amount)
    unless @single_partial.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    if @payment.update(payment_edit_params)
      redirect_to payment_path(@single_partial), notice: 'Pagamento Atualizado!'
    else
      render :show
    end
  end

  def show_date
    @payment = Payment.find(params[:id])
    @payments = Payment.where(date: @payment.date, partial: 1).sort_by { |event| [event.category.name] }
    @total_amount = 0
    @payments.each do |payment|
      @total_amount += payment.total_amount
    end
  end

  def show_due
    @payment = Payment.find(params[:id])
    @payments = Payment.where(due_date: @payment.due_date, credit_card_id: @payment.credit_card_id).sort do |a, b|
      [b[:date], a[:amount]] <=> [a[:date], b[:amount]]
    end
    @total_amount = 0
    @payments.each do |payment|
      @total_amount += payment.amount
    end
  end


  # def show_category
  #   @payment = Payment.find(params[:id])
  #   @payments = Payment.where(month_due: @payment.due_date.month, category: @payment.category).sort_by { |event| [event.date] }
  #   @total_amount = 0
  #   @payments.each do |payment|
  #     @total_amount += payment.amount
  #   end
  # end

  def destroy
    @payment = Payment.find(params[:id])
    unless @payment.user == current_user
      redirect_to root_path, notice: 'Not allowed to Delete 😠'
    end
    @payments = Payment.where(month_due: @payment.due_date.month.to_i, category: @payment.category, description: @payment.description, total_partial: @payment.total_partial)
    @payments.destroy_all
    redirect_to root_path, notice: 'Payment destroyed!'
  end

  private

  def due_date(partial)
    if CreditCard.find(params[:payment][:credit_card_id]).best_day > CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) >= Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
      @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 2).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      case @payment.due_date.wday
      when 0
        @payment.due_date = @payment.due_date + 1.day
      when 6
        @payment.due_date = @payment.due_date + 2.day
      end
    elsif CreditCard.find(params[:payment][:credit_card_id]).best_day > CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) < Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
      @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 1).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      case @payment.due_date.wday
      when 0
        @payment.due_date = @payment.due_date + 1.day
      when 6
        @payment.due_date = @payment.due_date + 2.day
      end
    elsif CreditCard.find(params[:payment][:credit_card_id]).best_day < CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) >= Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
      @payment.due_date = (Date.parse(params[:payment][:date]) + (partial + 1).month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      case @payment.due_date.wday
      when 0
        @payment.due_date = @payment.due_date + 1.day
      when 6
        @payment.due_date = @payment.due_date + 2.day
      end
    elsif CreditCard.find(params[:payment][:credit_card_id]).best_day < CreditCard.find(params[:payment][:credit_card_id]).due_day && Date.parse(params[:payment][:date]) < Date.parse("#{CreditCard.find(params[:payment][:credit_card_id]).best_day}/#{Date.parse(params[:payment][:date]).month}/#{Date.parse(params[:payment][:date]).year}")
      @payment.due_date = (Date.parse(params[:payment][:date]) + partial.month).change(day: CreditCard.find(params[:payment][:credit_card_id]).due_day)
      case @payment.due_date.wday
      when 0
        @payment.due_date = @payment.due_date + 1.day
      when 6
        @payment.due_date = @payment.due_date + 2.day
      end
    end
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
                                    :total_amount,
                                    :comment)
  end

  def payment_edit_params
    params.require(:payment).permit(:description,
                                    :user_id,
                                    :category_id,
                                    :comment)
  end
end
