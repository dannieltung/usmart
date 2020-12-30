class AddUserReferenceToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :user, index: true
    add_foreign_key :payments, :users
  end
end
