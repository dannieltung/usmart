class RemoveDueDayFromCreditCards < ActiveRecord::Migration[6.0]
  def change
    remove_column :credit_cards, :due_day
  end
end
