class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.references :user, foreign_key: true
      t.string :username
      t.string :password
      t.string :server
      t.integer :port
      t.string :login
      t.boolean :ssl

      t.timestamps
    end
  end
end
