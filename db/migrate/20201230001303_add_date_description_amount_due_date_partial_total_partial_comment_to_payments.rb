class AddDateDescriptionAmountDueDatePartialTotalPartialCommentToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :amount, :float
    add_column :payments, :due_date, :date
    add_column :payments, :partial, :integer
    add_column :payments, :total_partial, :integer
    add_column :payments, :comment, :string
  end
end
