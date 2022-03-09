class CreateVerifications < ActiveRecord::Migration[7.0]
	def change
		create_table :verifications do |t|
			t.references :user, null: false, foreign_key: true
			t.string :status, default: 'pending'
			t.uuid :token, default: 'uuid_generate_v4()'
			t.references :verificationable, polymorphic: true, index: true

			t.timestamps
		end
		add_index :verifications, :status
		add_index :verifications, :token, unique: true
		add_index :verifications, :verificationable_type
	end
end
