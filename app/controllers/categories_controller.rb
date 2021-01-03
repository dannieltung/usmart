class CategoriesController < ApplicationController
  def new
    @categories = Category.all.select do |category|
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
