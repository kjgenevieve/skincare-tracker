class Ingredient < ApplicationRecord
    has_many :product_ingredients
    has_many :products, through: :product_ingredients

    def ingredients_user_products
        
        # products.each do |product|
            
        #     product.user_products.each do |user_product|
        #         {
        #             "id": user_product.id,
        #             "user_id": user_product.user_id,
        #             "current": user_product.current,
        #             "rating": user_product.rating,
        #             "wishlist": user_product.wishlist,
        #             "opened": user_product.opened,
        #             "expires": user_product.expires,
        #             "caused_acne": user_product.caused_acne,
        #             "notes": user_product.notes,
        #             "product": {
        #                 "id": user_product.product_id,
        #                 "brand": user_product.product.brand,
        #                 "name": user_product.product.name,
        #                 "category": user_product.product.category,
        #                 "img_url": user_product.product.img_url,
        #                 "sunscreen_type": user_product.product.sunscreen_type,
        #                 "spf": user_product.product.spf,
        #                 "pa": user_product.product.pa,
        #                 "created_at": user_product.product.created_at,
        #                 "updated_at": user_product.product.updated_at,
        #             }
        #         }
        #     end
        # end
    end
end
