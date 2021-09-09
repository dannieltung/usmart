class AddTipoReferenceToAtivos < ActiveRecord::Migration[6.0]
  def change
    add_reference :ativos, :tipo, index: true
    add_foreign_key :ativos, :tipos
  end
end
