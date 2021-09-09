class AtivosController < ApplicationController
  def index
    @tipos = Tipo.where(user_id: current_user.id)
    @ativos = Ativo.where(user_id: current_user.id)
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
    params.require(:ativo).permit(:tipo_id,
                                  :nome,
                                  :quantidade,
                                  :preco)
  end
end
