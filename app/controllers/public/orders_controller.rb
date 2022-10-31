class Public::OrdersController < ApplicationController
    def new
      @order = Order.new
    end
  
    def create
      cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
      if @order.save
        cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.order_quantity = cart.quantity
        order_item.order_price = cart.item.price
        order_item.save
      end
        redirect_to orders_confirm_path
        cart_items.destroy_all
      else
        @order = Order.new(order_params)
        render :new
      end
    end
  
    def confirm
      @order = Order.new(order_params)
        if params[:order][:address_number] == "0"
          @order.name = current_customer.name 
          @order.address = current_customer.address
          @order.postal_code = current_customer.postal_code
        elsif params[:order][:address_number] == "1"
          @order.name = Address.find(params[:order][:address_id]).name
          @order.address = Address.find(params[:order][:address_id]).address
          @order.postal_code = Address.find(params[:order][:address_id]).postal_code
        elsif params[:order][:address_number] == "2"
          address_new = current_customer.addresses.new(address_params)
          if address_new
          else
            render :new
          end
        else
          redirect_to orders_new_path
        end
        @cart_items = current_customer.cart_items.all
        @total = 0
    end
    
    private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name)
    end
    
    def address_params
      params.require(:order).permit(:name, :address, :postal_code)
    end
end
