class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @previous_url = request.referrer
    @categories = Category.where(user_id: current_user.id).where.not(name: '').order('name ASC')
    # @categories = Category.all.sort_by { |event| [event.name] }.select do |category|
    #   category.user == current_user
    # end
    # @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    @category.user = current_user
    if @category.save && params[:category][:previous_url].include?('payments/new')
      redirect_to new_payment_path, notice: 'Cartão de Crédito Adicionado.'
    elsif @category.save
      redirect_to root_path, notice: 'Cartão de Crédito Adicionado.'
    else
      render :new
    end
  end

  def edit
    @payment = Payment.find(params[:id])
    @payments = Payment.where(month_due: @payment.date.month, category: @payment.category).sort_by { |event| [event.date] }
    @total_amount = 0
    @payments.each do |payment|
      @total_amount += payment.amount
    end
    @category = Category.find(@payment.category_id)
    unless @category.user == current_user
      redirect_to root_path, notice: 'Not allowed to Edit 😥'
    end
  end

  def update
  end

  def destroy
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end

end
