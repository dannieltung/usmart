class AddUserReferenceToCreditCards < ActiveRecord::Migration[6.0]
  def change
    add_reference :credit_cards, :user, index: true
    add_foreign_key :credit_cards, :users
  end
end
