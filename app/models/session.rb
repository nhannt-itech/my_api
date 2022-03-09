class Session < ApplicationRecord
	TOKEN_LENGTH = 32
	TOKEN_LIFETIME = 1.hour

	validates :token, presence: true, uniqueness: { case_sensitive: true }

	belongs_to :user

	before_validation :generate_token, on: :create

	def is_late?
		if (last_used_at + TOKEN_LIFETIME) >= Time.now
			false
		else
			update(status: false)
			true
		end
	end

	def generate_token
		self.token = SecureRandom.uuid
	end
end
