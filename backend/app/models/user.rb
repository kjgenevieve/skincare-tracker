class User < ApplicationRecord
    has_many :journal_entries
    has_many :routines
    # has_many :steps through: :routines
    has_many :user_products
    has_many :products, through: :user_product    



    def user_ingredients
        user = User.where(name: "Genevieve")[0]
        
        ingredients_ary = []
        
        user.user_products.map do |u_product|
            ingredients_ary << u_product.product.ingredients
        end

        ingredients_ary = ingredients_ary.uniq

    end






end





