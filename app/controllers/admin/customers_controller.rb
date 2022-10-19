class Admin::CustomersController < ApplicationController
    before_action :if_not_admin
    
    def index
        @customers = Customer.all
    end
    
    private
    def if_not_admin
    redirect_to root_path unless current_admin
    end
end
