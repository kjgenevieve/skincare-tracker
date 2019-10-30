class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :goals
      t.string :concern_1
      t.string :concern_2
      t.string :concern_3
      t.string :loved_ing
      t.string :avoid_ing

      t.timestamps
    end
  end
end
