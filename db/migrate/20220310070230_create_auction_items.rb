class CreateAuctionItems < ActiveRecord::Migration[7.0]
	def change
		create_table :auction_items do |t|
			t.string :title
			t.float :price
			t.float :shipping_cost
			t.integer :bids
			t.datetime :end_at
			t.references :user, null: false, foreign_key: true
			t.string :avatar

			t.timestamps
		end
	end
end
