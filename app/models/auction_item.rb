# == Schema Information
#
# Table name: auction_items
#
#  id            :bigint           not null, primary key
#  title         :string
#  price         :float
#  shipping_cost :float
#  bids          :integer
#  end_at        :datetime
#  user_id       :bigint           not null
#  avatar        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class AuctionItem < ApplicationRecord
	belongs_to :user

	validates :title, :price, :shipping_cost, :bids, :end_at, :avatar, presence: true

	has_many :images, as: :addressable, dependent: :destroy
end
