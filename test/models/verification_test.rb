# == Schema Information
#
# Table name: verifications
#
#  id                    :bigint           not null, primary key
#  user_id               :bigint           not null
#  status                :string           default("pending")
#  token                 :uuid
#  verificationable_type :string
#  verificationable_id   :bigint
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
require 'test_helper'

class VerificationTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end
end
