class RemoveCreditCardReferenceFromPayments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :payments, :credit_card, index: true, foreign_key: true
  end
end
