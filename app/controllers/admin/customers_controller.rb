class Admin::CustomersController < ApplicationController
    before_action :if_not_admin
    
    def index
        @customers = Customer.all
    end
    
    def show
        @customer = Customer.find(params[:id])
    end
    
    private
    def if_not_admin
    redirect_to root_path unless current_admin
    end
end
