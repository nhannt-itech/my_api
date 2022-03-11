module AuctionItemsService
	class GetAll < ApplicationService
		def initialize(offset, pagesize)
			@offset = offset || 0
			@pagesize = pagesize || 10
		end

		def call
			auction_items = AuctionItem.limit(@pagesize).offset(@offset)
			next_page = AuctionItem.count > (@pagesize.to_i * (@offset.to_i + 1))
			return { auction_items: auction_items, next_page: next_page }
		end
	end
end
