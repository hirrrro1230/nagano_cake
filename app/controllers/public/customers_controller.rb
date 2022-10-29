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
        if @customer != current_customer
            redirect_to customer_path(current_customer)
        end
    end
    
    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
          redirect_to customer_path(@customer.id), notice: "You have updated user successfully."
        else
          render :edit
        end
    end
    
    def unsubscribe
        @customer = Customer.find(params[:id])
    end
    
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
    end
end
