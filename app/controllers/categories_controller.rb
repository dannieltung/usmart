class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    @category.user = current_user
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

  def show
  end

  def index
  end

  def destroy
  end

  private

  def categories_params
    params.require(:category).permit(:name)
  end

end
