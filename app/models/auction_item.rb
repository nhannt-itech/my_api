class AuctionItem < ApplicationRecord
	belongs_to :user_id

	has_many :images, as: :imageable, dependent: :destroy
end
