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
require "test_helper"

class AuctionItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
