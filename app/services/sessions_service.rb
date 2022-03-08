class SessionsService < ApplicationService
	def self.create(email, password)
		user = User.find_by(email: email)
		if user && user.authenticate(password)
			session = Session.create(user_id: user.id)
			token = JsonWebToken.encode({ user_id: user.id, token: session.token })
			return { token: token, user: user }
		else
			return nil
		end
	end

	def self.destroy?(token)
		session = Session.find_by(token: JsonWebToken.decode(token)[:token])
		if session
			session.update(status: false)
			true
		else
			false
		end
	end
end
