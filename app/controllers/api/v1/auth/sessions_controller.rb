class Api::V1::Auth::SessionsController < ApplicationController
	include CreateSession

	before_action :authenticate_user, only: %i[validate_token destroy]

	def create
		return error_insufficient_params unless params[:email].present? && params[:password].present?
		result = SessionsService.create(params[:email], params[:password])
		if result
			@token = result[:token]
			@user = result[:user]
			response.headers['Authorization'] = "Bearer #{@token}"
			return render status: :created, template: 'auth/auth'
		else
			return(
				render status: 400, json: { errors: [I18n.t('errors.controllers.auth.invalid_credentials')] }
			)
		end
	end

	def validate_token
		@token = request.headers['Authorization'].split(' ').last
		@user = current_user
		success_valid_token
	end

	def destroy
		headers = request.headers['Authorization'].split(' ').last
		session = Session.find_by(token: JsonWebToken.decode(headers)[:token])
		session.close
		success_session_destroy
	end

	protected

	def success_session_created; end

	def success_valid_token
		response.headers['Authorization'] = "Bearer #{@token}"
		render status: :ok, template: 'auth/auth'
	end

	def success_session_destroy
		render status: :no_content, json: {}
	end

	def error_invalid_credentials; end

	def error_token_create
		render status: :unprocessable_entity,
		       json: {
				errors: [I18n.t('errors.controllers.auth.token_not_created')],
		       }
	end

	def error_insufficient_params
		render status: :unprocessable_entity,
		       json: {
				errors: [I18n.t('errors.controllers.insufficient_params')],
		       }
	end
end
