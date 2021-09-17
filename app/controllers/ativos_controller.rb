class AtivosController < ApplicationController
  def index
    @unique_ativos = Ativo.where(user_id: current_user.id).uniq { |ativo| ativo.nome }.sort_by { |ativo| ativo.nome }
  end

  def create
    @ativo = Ativo.new(ativo_params)
    @ativo.user = current_user
    if @ativo.save
      redirect_to ativos_path
    end
  end

  def show
    @ativo = Ativo.find(params[:id])
    @ativos = Ativo.where(nome: @ativo.nome).sort_by { |ativo| ativo.created_at }.reverse
    @stocks_income = Ativo.where(nome: @ativo.nome, quantidade: nil).map { |ativo| ativo.preco }.sum
    @stocks_value = Ativo.where(nome: @ativo.nome).where.not(quantidade: nil).map { |ativo| ativo.total }.sum
    @stocks_quantity = Ativo.where(nome: @ativo.nome).where.not(quantidade: nil).map { |ativo| ativo.quantidade }.sum
    @porcentagem = (@stocks_income / @stocks_value) * 100
  end

  def edit
    @ativo = Ativo.find(params[:id])
  end

  def update

  end

  private

  def ativo_params
    params.require(:ativo).permit(:nome,
                                  :quantidade,
                                  :preco)
  end
end
