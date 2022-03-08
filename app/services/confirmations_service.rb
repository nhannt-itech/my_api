class ConfirmationsService < ApplicationService
	def self.confirm_email?(token)
		verification = Verification.find_by(status: 'pending', token: token)
		if verification && ((verification.created_at + Verification::TOKEN_LIFETIME) > Time.now)
			verification.user.update(email_confirmed_at: Time.now)
			verification.update(status: :done)
			true
		else
			false
		end
	end
end
