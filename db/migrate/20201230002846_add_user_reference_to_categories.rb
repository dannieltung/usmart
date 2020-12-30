class AddUserReferenceToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user, index: true
    add_foreign_key :categories, :users
  end
end
