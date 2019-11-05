class User < ApplicationRecord
    has_many :journal_entries
    has_many :routines
    # has_many :steps through: :routines
    has_many :user_products
    has_many :products, through: :user_products

    def user_ingredients
        user = User.where(name: "Genevieve")[0]
        ingredients_ary = []
        
        user.user_products.map do |u_product|
            
            # puts "======================"
            # puts u_product.product
            # puts "======================"
            ingredients_ary << u_product.product.ingredients
            
        end

        ingredients_ary = ingredients_ary.uniq
    end

    # def product_ids
    #     product_id_ary = []
    #     user = User.where(name: "Genevieve")[0]
        
    #     user.user_products.map do |u_product|
    #         product_id_ary << u_product.product_id 
    #     end
    # end

    # def ingredients
    #     # All ingredients where the product matches
    # end


    

end





