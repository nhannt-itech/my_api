class ConfirmEmail < ApplicationRecord
	has_many :verifications, as: :verificationable
end
