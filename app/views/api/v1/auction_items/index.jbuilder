json.success true
json.data do
	json.next_page @result[:next_page]
	json.auction_items @result[:auction_items] do |auction_item|
		json.extract! auction_item, :id, :title, :price, :shipping_cost, :bids, :end_at, :avatar
	end
end
