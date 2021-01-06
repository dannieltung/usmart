class RenameMonthCreatedToMonthDue < ActiveRecord::Migration[6.0]
  def change
    rename_column :payments, :month_created, :month_due
  end
end
