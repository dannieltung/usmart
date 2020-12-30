class AddBuyerReferenceToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :buyer, index: true
    add_foreign_key :payments, :buyers
  end
end
