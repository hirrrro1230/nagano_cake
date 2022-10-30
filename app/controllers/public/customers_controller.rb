class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!
    
    def new
        @customer = Customer.new
    end
    
    def show
        @customer = current_customer
    end
    
    def edit
        @customer = current_customer
        if @customer != current_customer
            redirect_to customer_path(current_customer)
        end
    end
    
    def update
        @customer = current_customer
        if @customer.update(customer_params)
          redirect_to customer_path(@customer.id), notice: "You have updated user successfully."
        else
          render :edit
        end
    end
    
    def unsubscribe
        @customer = current_customer
    end
    
    def withdraw
        @customer = current_customer
        @customer.update(is_deleted: true)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    end
    
    def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
    end
end
