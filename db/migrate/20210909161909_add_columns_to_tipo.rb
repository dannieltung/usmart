class AddColumnsToTipo < ActiveRecord::Migration[6.0]
  def change
    add_column :tipos, :nome, :string
  end
end
