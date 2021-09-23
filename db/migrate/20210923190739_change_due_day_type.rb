class ChangeDueDayType < ActiveRecord::Migration[6.0]
  def change
    change_column :credit_cards, :due_day, :string
  end
end
