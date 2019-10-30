class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.integer :routine_id
      t.integer :product_id
      t.string :name
      t.string :days
      t.string :notes

      t.timestamps
    end
  end
end
