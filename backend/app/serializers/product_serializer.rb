class ProductSerializer < ActiveModel::Serializer
  attributes :id, :brand, :name, :category, :img_url, :sunscreen_type, :spf, :pa
  attributes :ingredients#, :product_ingredients
end