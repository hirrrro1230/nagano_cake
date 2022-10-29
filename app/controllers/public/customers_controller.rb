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
    
    def update
        @customer = Customer.find(params[:id])
        if customer.update(cusotmer_params)
          redirect_to customer_path(@customer.id), notice: "You have updated user successfully."
        else
          render :edit
        end
    end
    
    def unsubscribe
        @customer = Customer.find(params[:id])
    end
    
    def customer_params
        params.require(:customer).permit(:first_name, :profile_image, :introduction)
    end
end
