class AddDueDayToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :due_day, :integer
  end
end
