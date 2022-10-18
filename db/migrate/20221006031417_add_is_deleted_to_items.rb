class AddIsDeletedToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :is_active, :boolean, null: false
  end
end
