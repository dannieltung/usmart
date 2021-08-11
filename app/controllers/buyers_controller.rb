class BuyersController < ApplicationController
  before_action :set_buyer, only: %i[edit update destroy]
  def index
    @buyer = Buyer.new
    @buyers = Buyer.where(user_id: current_user.id)
  end

  def create
    @buyer = Buyer.new(buyers_params)
    @buyer.user = current_user
    if @buyer.save
      redirect_to buyers_path, notice: 'Comprador Criado!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless @buyer.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    if @buyer.update(buyers_params)
      redirect_to buyers_path, notice: 'Comprador Atualizado!'
    else
      render :edit
    end
  end

  def destroy
    unless @buyer.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    @buyer.destroy
    redirect_to buyers_path, notice: 'Comprador Apagado!'
  end

  # def new
  #   @buyer = Buyer.new
  #   @buyers = Buyer.where(user_id: current_user.id)
  # end
  private

  def set_buyer
    @buyer = Buyer.find(params[:id])
  end

  def buyers_params
    params.require(:buyer).permit(:name)
  end
end
