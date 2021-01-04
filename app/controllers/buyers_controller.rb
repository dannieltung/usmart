class BuyersController < ApplicationController
  def new
    @buyers = Buyer.all.sort_by { |event| [event.name] }.select do |buyer|
      buyer.user == current_user
    end
    @buyer = Buyer.new
  end

  def create
    @buyer = Buyer.new(buyers_params)
    @buyer.user = current_user
    if @buyer.save
      redirect_to root_path, notice: 'Buyer created!'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def buyers_params
    params.require(:buyer).permit(:name)
  end
end
