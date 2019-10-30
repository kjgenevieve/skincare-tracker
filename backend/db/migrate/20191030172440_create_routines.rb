class CreateRoutines < ActiveRecord::Migration[6.0]
  def change
    create_table :routines do |t|
      t.integer :user_id
      t.string :name
      t.boolean :current
      t.date :started
      t.date :ended
      t.string :comment
      t.string :dicont_bc

      t.timestamps
    end
  end
end
