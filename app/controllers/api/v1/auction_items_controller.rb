class Api::V1::AuctionItemsController < ApplicationController
	def create
		result = AuctionItemsService::Create.call(auction_item_params)
	end

	private

	def auction_item_params
		params.require(:item).permit(:title, :price, :shipping_cost, :bids, :end_at, :image)
	end
end
