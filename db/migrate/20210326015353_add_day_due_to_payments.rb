class AddDayDueToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :day_due, :integer
  end
end
