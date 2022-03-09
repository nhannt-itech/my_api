class Session < ApplicationRecord
	TOKEN_LENGTH = 32
	TOKEN_LIFETIME = 1.hour

	validates :token, presence: true, uniqueness: { case_sensitive: true }
	belongs_to :user
end
