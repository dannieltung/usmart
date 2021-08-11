class AddStatusToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :status, :boolean
  end
end
