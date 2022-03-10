# == Schema Information
#
# Table name: reset_emails
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ResetEmail < ApplicationRecord
	has_many :verifications, as: :verificationable
end
