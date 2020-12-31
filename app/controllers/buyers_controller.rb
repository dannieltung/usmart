class BuyersController < ApplicationController
  def new
    @buyer = Buyer.new
  end

  def create
    @buyer = Buyer.new
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

  def show
  end

  def index
  end

  def destroy
  end

  private

  def buyers_params
  end
end
