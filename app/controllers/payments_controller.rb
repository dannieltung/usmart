class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payments_params)
    @payment.user = current_user
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
    params.require(:payment).permit(:amount, :total_partial, :comment, :date, :description)
  end
end
