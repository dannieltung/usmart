class AddNameDueDayBestDayToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :name, :string
    add_column :credit_cards, :due_day, :date
    add_column :credit_cards, :best_day, :date
  end
end
