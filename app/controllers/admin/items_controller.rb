class Admin::ItemsController < ApplicationController
    def new
        @item = Item.new
    end
    
    def create
        @item = Item.new(item_prams)
        @item = Item.save
        redirect_to items_path
    end
    
    def index
        @items = Item.all
    end
    
    def show
        @item = Item.find(prams[:id])
    end
    
    private
  # ストロングパラメータ
    def list_params
        params.require(:item).permit(:name, :introduction)
    end
end
