class JsonWebToken
	SECRET_KEY = ENV['JWT_SECRET']

	JWT_EXPIRY = 1.day

	def self.encode(payload, exp = JWT_EXPIRY.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, SECRET_KEY, 'HS512')
	end

	def self.decode(token)
		decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS512' })[0]
		res = HashWithIndifferentAccess.new decoded
		Time.at(res[:exp]) > Time.now ? res : nil
	rescue StandardError
		return nil
	end
end
