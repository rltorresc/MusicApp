class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.references :album, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :ord, null: false
      t.text :lyrics
      t.boolean :regular, null: false, default: true
      t.timestamps
    end
  end
end
