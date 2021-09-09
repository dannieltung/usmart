class AddColumnsToAtivos < ActiveRecord::Migration[6.0]
  def change
    add_column :ativos, :nome, :string
    add_column :ativos, :quantidade, :integer
    add_column :ativos, :preco, :float
    add_column :ativos, :liquidacao, :float
    add_column :ativos, :emolumentos, :float
  end
end
