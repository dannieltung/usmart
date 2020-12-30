class AddCategoryReferenceToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :category, index: true
    add_foreign_key :payments, :categories
  end
end
