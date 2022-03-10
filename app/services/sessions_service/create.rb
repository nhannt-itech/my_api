module SessionsService
	class Create < ApplicationService
		include RegexConstants

		def initialize(email, password)
			@email = email
			@password = password
		end

		def call
			user = User.find_by(email: @email)
			if user && user.authenticate(@password)
				new_token = SecureRandom.uuid
				session = Session.create(user_id: user.id, token: new_token)
				token = JsonWebToken.encode({ user_id: user.id, token: session.token })
				return { token: token, user: user }
			else
				return nil
			end
		end
	end
end
