class AtivosController < ApplicationController
  def index
    @ativos = Ativo.where(user_id: current_user.id).sort_by { |ativo| ativo.created_at }.reverse
  end

  def create
    @ativo = Ativo.new(ativo_params)
    @ativo.user = current_user
    if @ativo.save
      redirect_to ativos_path
    end
  end

  private

  def ativo_params
    params.require(:ativo).permit(:nome,
                                  :quantidade,
                                  :preco)
  end
end
