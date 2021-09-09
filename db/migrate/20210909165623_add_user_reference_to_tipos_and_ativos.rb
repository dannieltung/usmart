class AddUserReferenceToTiposAndAtivos < ActiveRecord::Migration[6.0]
  def change
    add_reference :tipos, :user, index: true
    add_foreign_key :tipos, :users
    add_reference :ativos, :user, index: true
    add_foreign_key :ativos, :users
  end
end
