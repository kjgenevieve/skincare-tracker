class IngredientsController < ApplicationController
    def index
        render json: Ingredient.all
    end

    def show
        render json: Ingredient.find(params[:id])
    end


    def ingredient_params
        # byebug
        params.permit(:id, :ingredient_id)
        
        ingredient = Ingredient.find(params[:ingredient_id])
        user = User.find(13)
        # user_products = user.user_products

        raw_ingredient_products = [ingredient.products]
        flat_ingredient_products = raw_ingredient_products.flatten
        raw_prod_ids = []
        
        flat_ingredient_products.map do |product|
            raw_prod_ids << product.id
        end

        # user_products_ids = []
        # user.products.map do |product|
        #     user_products_ids << product.id
        # end

        ingredient_products = []

        user.user_products.each do |product|
            
            if raw_prod_ids.include?(product.product_id)
                puts product
                ingredient_products << product
                # byebug
            end

        end


        # puts "=============="
        # ingredient_products
        # byebug
        # puts "=============="


        ingredient_products.each do |product|
            puts "=================="
            puts product.product.id
            puts "=================="

            sought_id = product.product_id
            # puts "=================="
            # puts product.product.id
            # puts "=================="

            sought_product = Product.find(sought_id)
            
            
            puts "=================="
            puts sought_product.id
            puts "=================="
            product[:product_id] = 56
            puts {product = product, test = "TEST"}
            # [
                # "id": sought_product.id
                # sought_id
            # ]
            # product
            
            
            # {sought_product
            # # ingredient_products[] ||= "Yo"



            # id
            # brand
            # name
            # category
            # img_url
            # sunscreen_type
            # spf
            # pa
        end

        # user.products.ingredients.each do |product_ingredient|
        #     if product_ingredient.id == ingredient.id
        #         ingredientProducts << product
        #     end
        

        render json: {
            ingredient_id: params[:ingredient_id],
            name: ingredient.name,
            como_rating: ingredient.como_rating,
            products: ingredient_products
        }
    end
end