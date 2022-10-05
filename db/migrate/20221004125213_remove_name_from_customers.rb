class RemoveNameFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :first_name, :string
  end
end
