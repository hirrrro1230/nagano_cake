class Public::CustomersController < ApplicationController
    def new
        @customer = Customer.new
    end
    
    def show
        @customer = Customer.find(params[:id])
    end
    
    def unsubscribe
        @customer = Customer.find(params[:id])
    end
end
