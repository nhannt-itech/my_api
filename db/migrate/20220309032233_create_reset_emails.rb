class CreateResetEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :reset_emails do |t|

      t.timestamps
    end
  end
end
