class Api::V1::Auth::ConfirmationsController < ApplicationController
	include CreateSession

	def confirm_email
		unless params[:token]
			return(
				render status: :unprocessable_entity,
				       json: {
						errors: [I18n.t('errors.controllers.insufficient_params')],
				       }
			)
		end

		verification = Verification.search(:pending, :confirm_email, params[:token])
		if verification.nil?
			return(
				render status: :unauthorized,
				       json: {
						errors: [I18n.t('errors.controllers.verifications.invalid_token')],
				       }
			)
		end
		if (verification.created_at + Verification::TOKEN_LIFETIME) > Time.now
			verification.user.confirm
			verification.update(status: :done)
			@token = jwt_session_create verification.user_id

			render status: :ok, json: { message: I18n.t('messages.confirm_email') }
			# Redirect to the page that says the email is confirmed successfully or can be redirected to the app
			# redirect_to "#{ENV['REDIRECT_CONFIRM_EMAIL']}?token=#{@token}"
		else
			render status: :unauthorized, json: { errors: [I18n.t('errors.controllers.verifications.late')] }
		end
	end

	def resend_confirm_email
		current_user.send_confirm_email
		render status: :ok, json: { message: I18n.t('messages.resend_confirm_email') }
	end
end
