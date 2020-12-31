class PaymentsController < ApplicationController
  def create
    b = params[:payment][:total_partial].to_i
    params[:payment][:total_partial].to_i.times do
      @payment = Payment.new(payments_params)
      @payment.user = current_user
      @payment.partial = b
      @payment.save
      b -= 1
    end
    if @payment.save
      redirect_to root_path, notice: 'Payment created!'
    else
      render :new
    end
  end

  # def create
  #   @payment = Payment.new(payments_params)
  #   @payment.user = current_user
  #   if @payment.save
  #     redirect_to root_path, notice: 'Payment created!'
  #   else
  #     render :new
  #   end
  # end

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
