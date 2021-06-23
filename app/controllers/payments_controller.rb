class PaymentsController < ApplicationController

  def new
    @payment = Payment.new
    @credit_cards = CreditCard.where(user_id: current_user.id).sort_by { |event| [event.name] }
    @buyers = Buyer.where(user_id: current_user.id).sort_by { |event| [event.name] }
    @categories = Category.where(user_id: current_user.id).sort_by { |event| [event.name] }
  end

  def create
    if params[:payment][:total_partial].empty?
      installments = 1
    else
      installments = params[:payment][:total_partial].to_i
    end
    flag = rand(1..1_000_000)
    partial = 1
    installments.times do
      @payment = Payment.new(payments_params)
      @payment.flag = flag
      @payment.user = current_user
      @payment.credit_card = CreditCard.find_by(user_id: current_user.id) if params[:payment][:credit_card_id].nil?
      @payment.buyer = Buyer.find_by(user_id: current_user.id) if params[:payment][:buyer_id].nil?
      @payment.category = Category.find_by(user_id: current_user.id) if params[:payment][:category_id].empty?
      @payment.amount = (params[:payment][:total_amount].to_f / installments).round(2)
      @payment.partial = partial
      unless params[:payment][:date].empty?
        due_date(partial)
      end
      # @payment.month_due = @payment.due_date.month
      # @payment.day_due = @payment.due_date.day
      # @payment.month_date = @payment.date.month
      # @payment.year_date = @payment.date.year
      # @payment.save
      partial += 1
      unless @payment.save
        render :new
      end
    end
    redirect_to root_path
  end

  def due_date(partial)
    if (Date.parse(params[:payment][:date]) >= Date.parse(@payment.credit_card.best_day.to_s)) && (@payment.credit_card.due_day < @payment.credit_card.best_day.day)
      @payment.due_date = Date.parse(@payment.credit_card.due_day.to_s.rjust(2,'0')) + (partial + 1).month
    elsif (Date.parse(params[:payment][:date]) < Date.parse(@payment.credit_card.best_day.to_s)) && (@payment.credit_card.due_day > @payment.credit_card.best_day.day)
      @payment.due_date = Date.parse(@payment.credit_card.due_day.to_s.rjust(2,'0')) + (partial - 1).month
    else
      @payment.due_date = Date.parse(@payment.credit_card.due_day.to_s.rjust(2,'0')) + partial.month
    end
    @payment.due_date = @payment.due_date + 1.day if @payment.due_date.wday == 0
    @payment.due_date = @payment.due_date + 2.day if @payment.due_date.wday == 6
  end

  def edit
    @payment = Payment.find(params[:id])
    unless @payment.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    @payments = Payment.where(flag: @payment.flag, date: @payment.date, total_amount: @payment.total_amount, total_partial: @payment.total_partial)
  end

  def show
    @payment = Payment.find(params[:id])
    @payments = Payment.where(flag: @payment.flag, date: @payment.date, total_amount: @payment.total_amount, total_partial: @payment.total_partial).sort_by { |event| [event.due_date] }
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

  def single_update
    @single_partial = Payment.find(params[:id])
    unless @single_partial.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
    if @single_partial.update(payment_edit_params)
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
    @payments = Payment.where(due_date: @payment.due_date, credit_card_id: @payment.credit_card_id).sort_by { |event| [event.amount]}
    @total_amount = 0
    @payments.each do |payment|
      @total_amount += payment.amount
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    unless @payment.user == current_user
      redirect_to root_path, notice: 'Not allowed to Delete 😠'
    end
    @payments = Payment.where(flag: @payment.flag, date: @payment.date, total_partial: @payment.total_partial, total_amount: @payment.total_amount)
    @payments.destroy_all
    redirect_to root_path, notice: 'Payment destroyed!'
  end

  # def show_category
  #   @payment = Payment.find(params[:id])
  #   @payments = Payment.where(month_due: @payment.due_date.month, category: @payment.category).sort_by { |event| [event.date] }
  #   @total_amount = 0
  #   @payments.each do |payment|
  #     @total_amount += payment.amount
  #   end
  # end

  private

  def payments_params
    params.require(:payment).permit(:amount,
                                    :date,
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
                                    :comment,
                                    :amount)
  end
end
