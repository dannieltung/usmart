class ChangeCreditCardsColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :credit_cards, :status, :boolean, default: true
  end
end
