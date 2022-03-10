module SessionsService
	class Destroy < ApplicationService
		include RegexConstants

		def initialize(token)
			@token = token
		end

		def call
			session = Session.find_by(token: JsonWebToken.decode(@token)[:token])
			if session
				session.update(status: false)
				true
			else
				false
			end
		end
	end
end
