class AddUserReferenceToBuyers < ActiveRecord::Migration[6.0]
  def change
    add_reference :buyers, :user, index: true
    add_foreign_key :buyers, :users
  end
end
