class ChangeDividendosToIncomesOnAtivos < ActiveRecord::Migration[6.0]
  def change
    rename_column :ativos, :dividendos, :incomes
  end
end
