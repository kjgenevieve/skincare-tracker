class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :como_rating
  belongs_to :products
end
