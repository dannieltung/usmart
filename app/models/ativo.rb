class Ativo < ApplicationRecord
  belongs_to :user

  before_create :ajuste

  private

  def ajuste
    self.nome = nome.upcase
    unless quantidade.nil?
      self.emolumentos = quantidade * preco * (0.0300/100)
      self.preco = (quantidade * preco + self.emolumentos)/quantidade
      self.total = quantidade * self.preco
    end
  end
end
