class User < ApplicationRecord
    has_secure_password
    has_many :sessions, dependent: :destroy
    has_many :user_verifications, dependent: :destroy

end
