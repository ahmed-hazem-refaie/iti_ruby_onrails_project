class HomeController < ApplicationController
    include Devise::Controllers::Helpers 
    def index
        @activities = Hash.new
        @my_orders = Order.find_by from: current_user.id
        current_user.friends.each do |friend|
            @activities[friend] = friend.activites
        end
    end
end
