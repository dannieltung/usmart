class AddFromToPayments < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :from, :string
  end
end
