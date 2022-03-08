class Api::V1::Auth::ConfirmationsController < ApplicationController
	include CreateSession

	def confirm_email
		result = ConfirmationsService.confirm_email?(params[:token])
		if result
			render status: :ok, json: { message: I18n.t('messages.confirm_email') }
		else
			render status: :unauthorized,
			       json: {
					errors: [I18n.t('errors.controllers.verifications.invalid_token')],
			       }
		end
	end

	def resend_confirm_email
		current_user.send_confirm_email
		render status: :ok, json: { message: I18n.t('messages.resend_confirm_email') }
	end
end
