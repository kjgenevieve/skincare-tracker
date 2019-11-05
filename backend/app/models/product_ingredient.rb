class ProductIngredient < ApplicationRecord
    belongs_to :product
    belongs_to :ingredient
end
