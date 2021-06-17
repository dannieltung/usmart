class RemoveCategoryReferenceFromPayments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :payments, :category, index: true, foreign_key: true
  end
end
