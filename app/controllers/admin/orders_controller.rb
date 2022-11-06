class Admin::OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
        #@customer = Customer.find(params[:id])
    end
    
    def update
        @order = Order.find(params[:id])
        if @order.update(order_params)
            redirect_to admin_path
        else
            render :new
        end
    end    
       
    private
    def order_params
      params.require(:order).permit(:status)
    end  
     
end
