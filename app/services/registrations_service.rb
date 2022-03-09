class RegistrationsService
	include RegexConstants
	def self.create?(registration_params)
		@user = User.new(registration_params)
		@user.email&.downcase!
		if @user.save
			verification = Verification.create user_id: @user.id
			confirm_email = ConfirmEmail.create
			verification.update_attribute(:verificationable, confirm_email)
			SendEmailJob.perform_now(email, verification.token)
			return true
		else
			puts @user.errors.full_messages
			return false
		end
	end
end
