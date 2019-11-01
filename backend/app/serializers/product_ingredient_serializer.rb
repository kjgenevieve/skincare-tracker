class ProductIngredientSerializer < ActiveModel::Serializer
  attributes :id, :ingredient
  belongs_to :product
end