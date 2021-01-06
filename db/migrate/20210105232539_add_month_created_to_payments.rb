class AddMonthCreatedToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :month_created, :integer
  end
end
