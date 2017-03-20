class CreateMailentries < ActiveRecord::Migration[5.0]
  def change
    create_table :mailentries do |t|
      t.references :user, foreign_key: true, index: true
      t.references :filter, foreign_key: true, index: true
      t.references :user_file, foreign_key: true, index: true
      t.text :content
      t.string :message_id, index: true
      t.timestamp :received_at, index: true

      t.timestamps
    end
  end
end
