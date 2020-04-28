class HomeController < ApplicationController
    include Devise::Controllers::Helpers 
    def index
        @activities = Hash.new
        @my_orders = Order.where user_id: current_user.id
        print "*******************"
        print @my_orders
        current_user.friends.each do |friend|
            @activities[friend] = friend.activites
        end
    end
end
