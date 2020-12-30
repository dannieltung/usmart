class CreateFroms < ActiveRecord::Migration[6.0]
  def change
    create_table :froms do |t|

      t.timestamps
    end
  end
end
