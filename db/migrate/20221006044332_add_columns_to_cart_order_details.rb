class AddColumnsToCartOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :order_id, :integer, null: false
    add_column :order_details, :item_id, :integer, null: false 
    add_column :order_details, :price, :integer, null: false
    add_column :order_details, :amount, :integer, null: false
    add_column :order_details, :making_status, :integer, null: false
  end
end
