class AddNameToBuyers < ActiveRecord::Migration[6.0]
  def change
    add_column :buyers, :name, :string
  end
end
