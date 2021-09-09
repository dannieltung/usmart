class Ativo < ApplicationRecord
  belongs_to :user
  belongs_to :tipo
end
