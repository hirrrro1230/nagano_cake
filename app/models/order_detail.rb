class OrderDetail < ApplicationRecord
    
    belongs_to :order
    belongs_to :item
    
    def subtotal
        item.with_tax_price * amount
    end
    
    enum making_status: { making_unable: 0, waiting_make: 1, making: 2, making_finished: 3 }

end
