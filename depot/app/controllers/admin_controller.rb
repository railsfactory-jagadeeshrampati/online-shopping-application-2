class AdminController < ApplicationController

  def index
  	if (user_signed_in? && current_user.role == 'admin')	
 	   @total_orders = Order.count
 	else
 		redirect_to :controller => 'store', :action =>'index'
 	end
  end
end
