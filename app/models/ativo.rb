class Ativo < ApplicationRecord
  belongs_to :user

  before_create :ajuste

  private

  def ajuste
    self.nome = nome.upcase
    self.emolumentos = quantidade * preco * (0.0300/100)
    self.preco = (quantidade * preco + self.emolumentos)/quantidade
  end
end