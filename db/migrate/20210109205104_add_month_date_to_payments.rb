class AddMonthDateToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :month_date, :integer
  end
end
