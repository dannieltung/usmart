class RemoveBuyerReferenceFromPayments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :payments, :buyer, index: true, foreign_key: true
  end
end
