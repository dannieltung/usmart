class Tipo < ApplicationRecord
  belongs_to :user
  has_many :ativos
end
