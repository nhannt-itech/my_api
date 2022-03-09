class RegistrationsService
	include RegexConstants
	def self.create?(registration_params)
		@user = User.new(registration_params)
		@user.email&.downcase!
		if @user.save
			new_token = SecureRandom.uuid
			verification = Verification.create user_id: @user.id, token: new_token
			confirm_email = ConfirmEmail.create
			verification.update_attribute(:verificationable, confirm_email)
			SendEmailJob.perform_now(@user.email, verification.token)
			return true
		else
			puts @user.errors.full_messages
			return false
		end
	end
end
