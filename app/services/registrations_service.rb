class RegistrationsService
	def self.create?(registration_params)
		@user = User.new(registration_params)
		puts registration_params
		if @user.save
			return true
		else
			return false
		end
	end
end
