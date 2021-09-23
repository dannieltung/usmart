class ReAddCreditCardReferenceToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :credit_card, index: true
    add_foreign_key :payments, :credit_cards
  end
end
