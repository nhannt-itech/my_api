class ResetEmail < ApplicationRecord
	has_many :verifications, as: :verificationable
end
