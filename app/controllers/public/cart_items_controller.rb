class Public::CartItemsController < ApplicationController
    def index
        @cart_items = current_customer.cart_items
        @total = 0
        @cart_item = CartItem.new
        if @cart_item.save
            redirect_to new_order_path
        end
        @cart_items.each do |cart_item| 
            tal = cart_item.item.with_tax_price * cart_item.amount
        @total += tal
        end
    end
    
    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.customer_id = current_customer.id
        @cart_items = current_customer.cart_items
        @cart_items.each do |cart_item|
        if cart_item.item_id == @cart_item.item_id
            new_amount = cart_item.amount + @cart_item.amount
            cart_item.update(amount: new_amount)
            return redirect_to cart_items_path
        end 
        end
        @cart_item.save
        redirect_to :cart_items
    end
    
    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(cart_item_params)
        redirect_to cart_items_path
    end
    
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy!
        redirect_to cart_items_path
    end
    
    def destroy_all
        cart_items = current_customer.cart_items
        cart_items.destroy_all
        redirect_to cart_items_path
    end

    private
      def cart_item_params
          params.require(:cart_item).permit(:item_id, :amount, :address_id)
      end
end
