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
class Verification < ApplicationRecord
	TOKEN_LENGTH = 32
	TOKEN_LIFETIME = 24.hours

	validates :status, presence: true, inclusion: %w[pending done failed]
	validates :token, presence: true, uniqueness: { case_sensitive: true }

	belongs_to :verificationable, polymorphic: true
	belongs_to :user

end
