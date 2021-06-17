class BuyersController < ApplicationController
  def new
    # @buyers = Buyer.all.sort_by { |event| [event.name] }.select do |buyer|
    #   buyer.user == current_user
    # end
    @buyer = Buyer.new
    @buyers = Buyer.where(user_id: current_user.id)
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
    @buyer = Buyer.find(params[:id])
  end

  def update
    @buyer = Buyer.find(params[:id])
    unless @buyer.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    if @buyer.update(buyer_params)
      redirect_to new_buyer_path, notice: 'Buyer Atualizada!'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def buyers_params
    params.require(:buyer).permit(:name)
  end
end
