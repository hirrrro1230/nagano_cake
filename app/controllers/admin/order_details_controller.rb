class Admin::OrderDetailsController < ApplicationController
    def show
        
    end
    
    def update
        
        @order_detail = OrderDetail.find(params[:id])
        @order = @order_detail.order
        @order_details = @order.order_details
        if @order_detail.update(order_detail_params)
            if @order_detail.making_status == "making"
                @order_detail.order.status = "making"
                @order_detail.order.save
            end
            if @order_details.where(making_status:"making_finished").count == @order_details.count
                @order_detail.order.status = "prepare_for"
                @order_detail.order.save
            end
            redirect_to admin_order_path(@order_detail.order.id)
        else
            render :new
        end
    end
    
    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end 
end
