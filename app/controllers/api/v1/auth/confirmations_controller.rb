class Api::V1::Auth::ConfirmationsController < ApplicationController
	include CreateSession

	def confirm_email
		result = ConfirmationsService.confirm_email?(params[:token])
		if result
			render status: :ok, json: { success: true, message: 'confirm email successfully!' }
		else
			render status: 400, json: { success: false, message: 'Invalid token.' }
		end
	end

	def resend_confirm_email
		current_user.send_confirm_email
		render status: :ok, json: { success: true, message: 'resend email successfully!' }
	end
end
