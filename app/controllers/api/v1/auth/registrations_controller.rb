class Api::V1::Auth::RegistrationsController < ApplicationController
	before_action :authenticate_user, only: :destroy

	def create
		result = RegistrationsService.create?(registration_params)
		if result
			render status: :created, json: {}
		else
			render status: :unprocessable_entity, json: { errors: 'error when register email' }
		end
	end

	def destroy
		current_user.destroy
		render status: :no_content, json: {}
	end

	private

	def registration_params
		params.permit(:name, :email, :password)
	end
end
