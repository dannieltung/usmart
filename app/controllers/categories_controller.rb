class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.where(user_id: current_user.id).where.not(name: 'Não Definido').order('name ASC')
  end

  def create
    @category = Category.new(categories_params)
    @category.user = current_user
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless @category.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    if @category.update(categories_params)
      redirect_to categories_path, notice: 'Categoria Atualizada!'
    end
  end

  def destroy
    unless @category.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    @category.destroy
    redirect_to categories_path, notice: 'Categoria Apagada!'
  end

  def new
    @category = Category.new
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def categories_params
    params.require(:category).permit(:name)
  end

end
