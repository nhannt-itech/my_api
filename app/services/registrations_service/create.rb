module RegistrationsService
	class Create < ApplicationService
		include RegexConstants

		def initialize(registration_params)
			@params = registration_params
		end

		def call
			@user = User.new(@params)
			@user.email&.downcase!
			if @user.save
				new_token = SecureRandom.uuid
				verification = Verification.create user_id: @user.id, token: new_token
				confirm_email = ConfirmEmail.create
				verification.update_attribute(:verificationable, confirm_email)
				SendEmailJob.perform_now(@user.email, verification.token)
				return true
			else
				return false
			end
		end
	end
end
