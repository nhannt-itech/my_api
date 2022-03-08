module AuthenticateRequest
	extend ActiveSupport::Concern

	def authenticate_user
		unless current_user
			return(
				render status: :unauthorized,
				       json: {
						errors: [I18n.t('errors.controllers.auth.unauthenticated')],
				       }
			)
		end
	end

	def current_user
		@current_user = nil
		if decoded_token
			data = decoded_token

			user = User.find_by(id: data[:user_id])

			session = Session.find_by(token: data[:token], status: true, user_id: data[:user_id])

			if user && session && !session.is_late?
				session.update(last_used_at: Time.now)
				@current_user ||= user
			end
		end
	end

	def decoded_token
		header = request.headers['Authorization']
		header = header.split(' ').last if header
		if header
			begin
				@decoded_token ||= JsonWebToken.decode(header)
			rescue Error => e
				return render json: { errors: [e.message] }, status: :unauthorized
			end
		end
	end
end
