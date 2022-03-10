module AuctionsService
	class Create
		def initialize(auction_item_params)
			@auction_item_params = auction_item_params
		end

		def call
			auction_item = AuctionItem.new auction_item_params
			if @item.save
				OpenStruct.new({ success?: true, data: auction_item })
			else
				OpenStruct.new(
					{ success?: false, errors: auction_item.errors, message: 'Error when create Auction item.' },
				)
			end
		end
	end
end
