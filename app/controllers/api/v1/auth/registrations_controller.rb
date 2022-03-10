class Api::V1::Auth::RegistrationsController < ApplicationController
	before_action :authenticate_user, only: :destroy

	def create
		result = RegistrationsService::Create.call(registration_params)
		if result
			render status: :ok, json: { success: true, message: 'Register successfully' }
		else
			render status: 400, json: { success: false, message: 'Error when register email!' }
		end
	end

	def destroy
		current_user.destroy
		render status: :ok, json: { success: true, message: 'Destroy user successfully' }
	end

	private

	def registration_params
		params.permit(:name, :email, :password)
	end
end
