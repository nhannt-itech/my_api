module AuctionItemsService
	class GetAll < ApplicationService
		def initialize; end

		def call
			auction_items = AuctionItem.all
			OpenStruct.new({ success?: true, data: auction_items })
		end
	end
end
