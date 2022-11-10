class Admin::OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
        #@customer = Customer.find(params[:id])
        @orders = @order.order_details
        #@order_detail = @order.order_detail
        @order.shipping_cost = 800
        @total = @order.total_payment + @order.shipping_cost
    end
    
    def update
        @order = Order.find(params[:id])
        if @order.update(order_params)
            redirect_to admin_order_path(@order.id)
        else
            render :new
        end
    end    
       
    private
    def order_params
      params.require(:order).permit(:status)
    end  
    
     
     
end
