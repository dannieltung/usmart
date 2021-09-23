class Ativo < ApplicationRecord
  belongs_to :user

  before_create :ajuste

  private

  def ajuste
    self.nome = nome.upcase
    unless quantidade.nil?
      quantidade = self.quantidade.abs
      self.emolumentos = quantidade * preco * (0.0300/100)
      if self.incomes == false
        self.preco = (quantidade * preco + self.emolumentos)/quantidade
      else
        self.preco = (quantidade * preco - self.emolumentos)/quantidade
      end
      self.total = quantidade * self.preco
    end
  end
end
