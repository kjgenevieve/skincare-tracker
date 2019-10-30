class CreateUserProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_products do |t|
      t.integer :user_id
      t.integer :product_id
      t.boolean :current
      t.integer :rating
      t.boolean :wishlist
      t.date :opened
      t.date :expires
      t.boolean :caused_acne
      t.string :notes

      t.timestamps
    end
  end
end
