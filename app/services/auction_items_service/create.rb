module AuctionItemsService
	class Create < ApplicationService
		def initialize(auction_item_params, current_user)
			@auction_item_params = auction_item_params
			@current_user = current_user
		end

		def call
			auction_item = AuctionItem.new (@auction_item_params)
			auction_item.user = @current_user
			auction_item.address.addressable = auction_item

			if auction_item.save
				OpenStruct.new({ success?: true, data: auction_item })
			else
				OpenStruct.new(
					{ success?: false, errors: auction_item.errors, message: 'Error when create Auction item.' },
				)
			end
		end
	end
end
