class AddBestDayToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_column :credit_cards, :best_day, :integer
  end
end
