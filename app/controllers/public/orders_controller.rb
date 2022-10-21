class Public::OrdersController < ApplicationController
    def confirm
      @order = Order.new(order_params)
    end
    
    private
    def order_params
      params.require(:order).permit(:payment_method)
    end
end
