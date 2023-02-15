class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.text :notes, null: false
      t.timestamps
    end
  end
end
