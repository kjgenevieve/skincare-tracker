class UserProductSerializer < ActiveModel::Serializer
  attributes :id, :current, :rating, :wishlist, :opened, :expires, :caused_acne, :notes
  attributes :user, :product
end