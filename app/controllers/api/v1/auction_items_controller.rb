class Api::V1::AuctionItemsController < ApplicationController
	before_action :authenticate_user, only: %i[create]

	def index
		result = AuctionItemsService::GetAll.call
		if result.success?
			render status: :ok, json: { success: true, data: result.data }
		else
			render status: 400, json: { success: false, message: result.message, errors: result.errors }
		end
	end

	def create
		result = AuctionItemsService::Create.call(auction_item_params, address_params, @current_user)
		if result[:success]
			render status: :ok, json: { success: true, data: result[:data] }
		else
			render status: 400, json: { success: false, message: result[:message], errors: result[:errors] }
		end
	end

	private

	def auction_item_params
		params.require(:auction_item).permit(:title, :price, :shipping_cost, :bids, :end_at, :avatar)
	end

	def address_params
		params.permit(:full_address)
	end
end
