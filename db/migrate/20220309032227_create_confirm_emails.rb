class CreateConfirmEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :confirm_emails do |t|

      t.timestamps
    end
  end
end
