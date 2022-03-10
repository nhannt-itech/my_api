module ConfirmationsService
	class ConfirmEmail < ApplicationService
		def initialize(token)
			@token = token
		end

		def call
			verification =
				Verification
					.where(status: :pending, verificationable_type: :ConfirmEmail)
					.find_by(token: @token)
			if verification && ((verification.created_at + Verification::TOKEN_LIFETIME) > Time.now)
				verification.user.update(email_confirmed_at: Time.now)
				verification.update(status: :done)
				true
			else
				false
			end
		end
	end
end
