class Ingredient < ApplicationRecord
    has_many :product_ingredients
    has_many :products, through: :product_ingredients
end
