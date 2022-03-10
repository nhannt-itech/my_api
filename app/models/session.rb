# == Schema Information
#
# Table name: sessions
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  last_used_at :datetime         default(Wed, 09 Mar 2022 09:08:58.558774000 UTC +00:00)
#  status       :boolean          default(TRUE)
#  token        :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Session < ApplicationRecord
	TOKEN_LENGTH = 32
	TOKEN_LIFETIME = 24.hours

	validates :token, presence: true, uniqueness: { case_sensitive: true }
	belongs_to :user
end
