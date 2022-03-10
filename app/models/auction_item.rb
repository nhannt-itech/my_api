class AuctionItem < ApplicationRecord
	belongs_to :user

	validates :title, :price, :shipping_cost, :bids, :end_at, :avatar, presence: true

	has_many :images, as: :addressable, dependent: :destroy
end
