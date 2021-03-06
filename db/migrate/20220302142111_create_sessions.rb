class CreateSessions < ActiveRecord::Migration[7.0]
	def change
		create_table :sessions do |t|
			t.references :user, null: false, foreign_key: true
			t.datetime :last_used_at, default: Time.now
			t.boolean :status, default: true
			t.uuid :token, default: 'uuid_generate_v4()'

			t.timestamps
		end
		add_index :sessions, :last_used_at
		add_index :sessions, :status
		add_index :sessions, :token, unique: true
	end
end
