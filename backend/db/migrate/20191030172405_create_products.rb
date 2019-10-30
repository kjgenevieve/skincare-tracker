class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :brand
      t.string :name
      t.string :category
      t.string :img_url
      t.string :sunscreen_type
      t.string :spf
      t.string :pa

      t.timestamps
    end
  end
end
