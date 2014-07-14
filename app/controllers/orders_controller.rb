class OrdersController < ApplicationController
	def index
		authenticate_admin!
		@orders = Order.all
	end
end
