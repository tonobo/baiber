class CreateFilters < ActiveRecord::Migration[5.0]
  def change
    create_table :filters do |t|
      t.references :email, foreign_key: true
      t.text :filters
      t.string :mailbox

      t.timestamps
    end
  end
end
