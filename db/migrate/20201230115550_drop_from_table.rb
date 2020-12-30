class DropFromTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :froms
  end
end
