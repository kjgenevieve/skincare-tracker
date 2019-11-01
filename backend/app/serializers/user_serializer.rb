class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_products, :user_ingredients
end
