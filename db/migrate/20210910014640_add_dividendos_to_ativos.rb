class AddDividendosToAtivos < ActiveRecord::Migration[6.0]
  def change
    add_column :ativos, :dividendos, :boolean
  end
end
