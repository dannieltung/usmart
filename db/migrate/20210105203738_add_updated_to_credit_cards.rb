class AddUpdatedToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :updated, :date
  end
end
