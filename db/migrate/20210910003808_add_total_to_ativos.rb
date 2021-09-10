class AddTotalToAtivos < ActiveRecord::Migration[6.0]
  def change
    add_column :ativos, :total, :float
  end
end
