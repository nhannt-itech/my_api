class SendEmail
	require 'sendgrid-ruby'
	include SendGrid

	def self.confirm_email(to_email, token)
		from = Email.new(email: 'nhannt.public@gmail.com')
		to = Email.new(email: to_email)
		subject = 'Confirm your email in My APP'

		content =
			Content.new(type: 'text/plain', value: "#{ENV['CLIENT_URL']}/identity/confirmation/#{token}")
		mail = Mail.new(from, subject, to, content)

		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
		puts response.status_code
		puts response.body
		puts response.headers
	end
end
