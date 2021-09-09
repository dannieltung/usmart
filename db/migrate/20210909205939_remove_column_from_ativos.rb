class RemoveColumnFromAtivos < ActiveRecord::Migration[6.0]
  def change
    remove_column :ativos, :liquidacao
  end

end
