class Verification < ApplicationRecord
	TOKEN_LENGTH = 32
	TOKEN_LIFETIME = 24.hours

	validates :status, presence: true, inclusion: %w[pending done failed]
	validates :token, presence: true, uniqueness: { case_sensitive: true }

	belongs_to :verificationable, polymorphic: true
	belongs_to :user

	before_validation :generate_token, on: :create

	def self.search(status = 'pending', verificationable_type = 'confirm_email', token)
		Verification.where(status: status, verificationable_type: verify_type).find_by(token: token)
	end

	def generate_token
		self.token =
			loop do
				random_token = SecureRandom.base58(TOKEN_LENGTH)
				break random_token unless Verification.exists?(token: random_token)
			end
	end
end
