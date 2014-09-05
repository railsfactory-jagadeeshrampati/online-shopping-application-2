class HistoryController < ApplicationController
	before_action :authenticate_user!
	def index
		 @mycart = current_user.line_items.where.not(:order_id =>"NULL")
	end
end
