class Item < ApplicationRecord
    
    has_many :cart_items
    belongs_to :genre
    has_many :order_details
    
    has_one_attached :image
    
    def with_tax_price
        (price * 1.1).floor
    end
end
