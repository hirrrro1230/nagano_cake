class Admin::OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
        #@customer = Customer.find(params[:id])
    end
    
    def updated
        @order = Order.find(params[:id])
    end    
       
    private
    def order_params
      params.require(:order).permit(:status)
    end  
     
end
