class AddResourceOwnerIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :resource_owner_id, :integer
    add_foreign_key :users, :users, column: :resource_owner_id
  end
end
