class Admin::OrderDetailsController < ApplicationController
    def show
        
    end
    
    def update
        @order_detail = OrderDetail.find(params[:id])
        if @order_detail.update(order_detail_params)
            redirect_to admin_order_path(@order_detail.order.id)
        else
            render :new
        end
    end
    
    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end 
end
