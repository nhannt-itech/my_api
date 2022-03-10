# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  full_address     :string
#  addressable_type :string           not null
#  addressable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
end
