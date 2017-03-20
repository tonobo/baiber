class CreateUserFileGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :user_file_groups do |t|
      t.string :desc
      t.string :name, index: true
      t.string :color

      t.timestamps
    end

    create_table :user_file_groups_files do |t|
      t.belongs_to :user_file, index: true
      t.belongs_to :user_file_group, index: true
    end
  end
end
