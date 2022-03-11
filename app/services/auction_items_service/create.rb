module AuctionItemsService
	class Create < ApplicationService
		def initialize(auction_item_params, address_params, current_user)
			@auction_item_params = auction_item_params
			@address_params = address_params
			@current_user = current_user
		end

		def call
			ActiveRecord::Base.transaction do
				auction_item = AuctionItem.new @auction_item_params
				auction_item.user = @current_user
				auction_item.addresses.new @address_params
				auction_item.save!
				{ success: true, data: auction_item }
			end
		rescue Exception => exception
			{ success: false, errors: exception.message, message: 'Error when create Auction item.' }
		end
	end
end
