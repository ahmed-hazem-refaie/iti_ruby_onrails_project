class HomeController < ApplicationController
    include Devise::Controllers::Helpers 
    def index
        @my_orders = Order.find_by from: current_user.id
    end
end
