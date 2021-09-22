class AtivosController < ApplicationController
  def index
    @unique_ativos = Ativo.where(user_id: current_user.id).uniq { |ativo| ativo.nome }.sort_by { |ativo| ativo.nome }
  end

  def create
    @ativo = Ativo.new(ativo_params)
    @ativo.user = current_user
    @ativo.incomes = false
    if @ativo.save
      redirect_to ativos_path
    end
  end

  def create_sold
    ativo = Ativo.find(params[:button])
    sold = Ativo.new(user_id: current_user.id,
                     nome: ativo.nome,
                     quantidade: params[:quantidade].to_i * -1,
                     preco: params[:preco])
    if sold.save
      redirect_to ativo_path(ativo)
    end
  end


  def show
    @ativo = Ativo.find(params[:id])
    @ativos = Ativo.where(nome: @ativo.nome).sort_by { |ativo| ativo.created_at }.reverse
    @stocks_income = Ativo.where(nome: @ativo.nome, quantidade: nil).map { |ativo| ativo.preco }.sum
    @stocks_value = Ativo.where(nome: @ativo.nome, incomes: false).map { |ativo| ativo.total }.sum
    @stocks_quantity = Ativo.where(nome: @ativo.nome).where.not(quantidade: nil).map { |ativo| ativo.quantidade }.sum
    @porcentagem = (@stocks_income / @stocks_value) * 100
  end

  def destroy
    ativo = Ativo.find(params[:id])
    unless ativo.user == current_user
      redirect_to root_path, notice: 'Ação não permitida 😥'
    end
    Ativo.where(nome: ativo.nome).each { |ativo| ativo.destroy }
    redirect_to ativos_path, notice: 'Ativo Apagado'
  end


  private

  def ativo_params
    params.require(:ativo).permit(:nome,
                                  :quantidade,
                                  :preco)
  end
end
