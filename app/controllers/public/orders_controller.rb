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
        elsif params[:order][:address_number] == "1"
          if Address.exists?(name: params[:order][:registered])
            @order.name = Address.find(params[:order][:registered]).name
            @order.address = Address.find(params[:order][:registered]).address
          else
            render :new
          end
        elsif params[:order][:address_number] == "2"
          address_new = current_customer.addresses.new(address_params)
          if address_new.save 
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
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :address_id)
    end
    
    def address_params
      params.require(:order).permit(:name, :address)
    end
end
