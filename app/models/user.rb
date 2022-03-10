# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  name               :string
#  email              :string
#  password_digest    :string
#  email_confirmed_at :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
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
	          },
	          if: :password_required?

	has_many :sessions, dependent: :destroy
	has_many :verifications, dependent: :destroy
	has_many :auction_items, dependent: :destroy
	has_many :address, as: :addressable, dependent: :destroy

	private

	# is password required for user?
	def password_required?
		password_digest.nil? || !password.blank?
	end
end
