class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!
    
    def new
        @customer = Customer.new
    end
    
    def show
        @customer = Customer.find(params[:id])
    end
    
    def edit
        @customer = Customer.find(params[:id])
    end
    
    def unsubscribe
        @customer = Customer.find(params[:id])
    end
end
