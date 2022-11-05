class Admin::HomesController < ApplicationController
    def top
        @orders = Order.all
        #@customer = Customer.find(params[:id])
    end
end
