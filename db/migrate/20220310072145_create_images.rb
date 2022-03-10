class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :link
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
