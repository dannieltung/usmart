class AddYearDateToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :year_date, :integer
  end
end
