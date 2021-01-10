class CategoriesController < ApplicationController
  def new
    @categories = Category.all.sort_by { |event| [event.name] }.select do |category|
      category.user == current_user
    end
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    @category.user = current_user
    @category.name = params[:category][:name].titleize
    if @category.save
      redirect_to root_path, notice: 'Category created!'
    else
      render :new
    end
  end

  def edit
    @payment = Payment.find(params[:id])
    @payments = Payment.where(month_due: @payment.due_date.month, category: @payment.category).sort_by { |event| [event.date] }
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
