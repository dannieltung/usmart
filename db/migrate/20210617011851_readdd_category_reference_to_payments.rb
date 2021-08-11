class ReadddCategoryReferenceToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :category, foreign_key: true
  end
end
