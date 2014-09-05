class MycartController < ApplicationController
	before_action :authenticate_user!
	def index
		 @added_to_cart=current_user.line_items.where(order_id: nil)
	end
		
	def delete
	       @line_item = LineItem.find(params[:item_id])
	       @line_item.destroy
	       respond_to do |format|
	       format.html { redirect_to mycart_index_path,notice: 'item removed' }
	       format.json { head :no_content }
	     end
	 end

	 def empty


	 end

end
