class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true
	validates :email,
	          presence: true,
	          uniqueness: {
			case_sensitive: false,
	          },
	          format: {
			with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/,
			message: I18n.t('errors.models.user.format_email'),
	          }
	validates :password,
	          format: {
			with: /\A(?=.*).{8,72}\z/,
			message: I18n.t('errors.models.user.format_password'),
	          },
	          if: :password_required?

	has_many :sessions, dependent: :destroy
	has_many :verifications, dependent: :destroy

	before_save :downcase_email!
	after_create :send_confirm_email

	def send_confirm_email
		unless !email_confirmed_at.nil?
			verification = Verification.create user_id: id
			confirm_email = ConfirmEmail.create
			verification.update_attribute(:verificationable, confirm_email)
			SendEmailJob.perform_later(email, verification.token)
		end
	end

	private

	# is password required for user?
	def password_required?
		password_digest.nil? || !password.blank?
	end

	# downcase email
	def downcase_email!
		email&.downcase!
	end
end
