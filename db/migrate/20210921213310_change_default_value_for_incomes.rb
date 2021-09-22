class ChangeDefaultValueForIncomes < ActiveRecord::Migration[6.0]
  def change
    change_column_default :ativos, :incomes, true
  end
end
