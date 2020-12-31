class RemoveBestDayFromCreditCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :credit_cards, :best_day
  end
end
