class AddFlagToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :flag, :integer
  end
end
