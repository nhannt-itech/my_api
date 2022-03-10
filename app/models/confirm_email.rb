# == Schema Information
#
# Table name: confirm_emails
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ConfirmEmail < ApplicationRecord
	has_many :verifications, as: :verificationable
end
