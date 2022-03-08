class CreateSession
	def self.jwt_session_create(user_id)
		user = User.find_by(id: user_id)
		session = Session.create(user_id: user_id)
		if user && session.save
			return JsonWebToken.encode({ user_id: user_id, token: session.token })
		else
			return nil
		end
	end
end
