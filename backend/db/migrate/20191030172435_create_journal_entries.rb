class CreateJournalEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :journal_entries do |t|
      t.datetime :entered
      t.integer :overall_rating
      t.integer :concern_1_rating
      t.integer :concern_2_rating
      t.integer :concern_3_rating
      t.string :img_front
      t.string :img_left
      t.string :img_right
      t.string :img_other

      t.timestamps
    end
  end
end
