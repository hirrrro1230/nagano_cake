class Admin::CustomersController < ApplicationController
    before_action :if_not_admin
    
    private
    def if_not_admin
    redirect_to root_path unless current_customer.admin?
    end  
end
