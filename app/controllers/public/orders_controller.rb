class Public::OrdersController < ApplicationController
    def index
      @customer = current_customer
      @orders = @customer.orders
    end
    
    def show
      @order = Order.find(params[:id])
      @order.shipping_cost = 800
      @total = @order.total_payment + @order.shipping_cost
    end
    
    def new
      @cart_items = current_customer.cart_items
      if @cart_items.empty?
        redirect_to cart_items_path
      end
      @order = Order.new
    end
  
    def create
      cart_items = current_customer.cart_items.all
      @order = current_customer.orders.new(order_params)
      @order.shipping_cost = 800
      @order.status = 0
      if @order.save
        cart_items.each do |cart|
        order_item = OrderDetail.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.price = cart.item.price
        order_item.making_status = 0
        order_item.save
      end
        cart_items.destroy_all
        redirect_to orders_complete_path
      else
        @order = Order.new(order_params)
        render :new
      end
    end
  
    def confirm
      @order = Order.new(order_params)
        if params[:order][:address_number] == "0"
          @order.name = current_customer.last_name+current_customer.first_name
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
    
    def complete
    end
    
    private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment)
    end
    
    def address_params
      params.require(:order).permit(:name, :address, :postal_code)
    end
end
