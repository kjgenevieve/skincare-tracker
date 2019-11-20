class IngredientsController < ApplicationController
    def index
        render json: Ingredient.all
    end

    def show
        render json: Ingredient.find(params[:id])
    end


    def ingredient_params
        params.permit(:id, :ingredient_id)
        ingredient = Ingredient.find(params[:ingredient_id])
        user = User.find(1)
        selected_products = []
        user_reviews = user.user_products.select do |review| 
            ingredients = review.product.ingredients
            if ingredients.include?(ingredient)
                selected_products << {user_notes: review, product: review.product}
            end
        end        

        render json: {
            ingredient_id: params[:ingredient_id],
            name: ingredient.name,
            como_rating: ingredient.como_rating,
            user_product_reviews: selected_products
        }
    end
end