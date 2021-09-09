class CreateAtivos < ActiveRecord::Migration[6.0]
  def change
    create_table :ativos do |t|

      t.timestamps
    end
  end
end
