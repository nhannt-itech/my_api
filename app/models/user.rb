class User < ApplicationRecord
	include RegexConstants
	has_secure_password

	validates :name, presence: true
	validates :email,
	          presence: true,
	          uniqueness: {
			case_sensitive: false,
	          },
	          format: {
			with: EmailRegex,
			message: I18n.t('errors.models.user.format_email'),
	          }
	validates :password,
	          format: {
			with: PasswordRegex,
			message: I18n.t('errors.models.user.format_password'),
	          }

	has_many :sessions, dependent: :destroy
	has_many :verifications, dependent: :destroy

	private
end
