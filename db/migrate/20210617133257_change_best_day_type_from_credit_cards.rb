class ChangeBestDayTypeFromCreditCards < ActiveRecord::Migration[6.0]
  def change
    change_column :credit_cards, :best_day, 'date USING CAST(best_day AS date)'
  end
end
