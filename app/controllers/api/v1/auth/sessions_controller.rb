class Api::V1::Auth::SessionsController < ApplicationController
	before_action :authenticate_user, only: %i[validate_token destroy]

	def create
		result = SessionsService.create(params[:email], params[:password])
		if result
			@token = result[:token]
			@user = result[:user]
			return render status: :created, template: 'auth/auth'
		else
			render status: 400, json: { errors: [I18n.t('errors.controllers.auth.invalid_credentials')] }
		end
	end

	def validate_token
		@token = request.headers['Authorization'].split(' ').last
		@user = current_user
		return render status: :ok, template: 'auth/auth'
	end

	def destroy
		@token = request.headers['Authorization'].split(' ').last
		result = SessionService.destroy?(@token)
		if result
			return render status: 200, json: {}
		else
			return render status: 400, json: { success: false }
		end
	end
end
