class RemoveTipoReferenceFromAtivos < ActiveRecord::Migration[6.0]
  def change
    remove_reference :ativos, :tipo, index: true, foreign_key: true
  end
end
