class CreateUserFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_files do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :content
      t.string :orig

      t.timestamps
    end
  end
end
