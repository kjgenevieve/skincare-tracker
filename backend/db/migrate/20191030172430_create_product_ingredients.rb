class CreateProductIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :product_ingredients do |t|
      t.integer :product_id
      t.integer :ingredient_id

      t.timestamps
    end
  end
end
