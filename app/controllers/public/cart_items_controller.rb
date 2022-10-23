class Public::CartItemsController < ApplicationController
    def index
        @cart_items = CartItem.all
        @cart_item = CartItem.create
        if @cart_item.save
            redirect_to new_order_path
        end
    end

    private
      def cart_item_params
          params.require(:cart_item).permit(:item_id, :amount)
      end
end
