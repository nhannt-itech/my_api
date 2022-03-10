class Api::V1::Auth::SessionsController < ApplicationController
	before_action :authenticate_user, only: %i[validate_token destroy]

	def create
		result = SessionsService::Create.call(params[:email], params[:password])
		if result
			@token = result[:token]
			@user = result[:user]
			render status: :created, template: 'auth/auth'
		else
			render status: 400,
			       json: {
					success: false,
					message: 'Email/Password is not correct. Please try again.',
			       }
		end
	end

	def validate_token
		@token = request.headers['Authorization'].split(' ').last
		@user = current_user
		render status: :ok, template: 'auth/auth'
	end

	def destroy
		@token = request.headers['Authorization'].split(' ').last
		result = SessionsService::Destroy.call(@token)
		if result
			render status: :ok, json: { success: true, message: 'destroy session successfully!' }
		else
			render status: 400, json: { success: false, message: 'Error when destroy session.' }
		end
	end
end
