class AddTotalAmountToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :total_amount, :float
  end
end
