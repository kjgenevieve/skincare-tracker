class IngredientsController < ApplicationController
    def index
        render json: Ingredient.all
    end

    def show
        render json: Ingredient.find(params[:id])
    end


    def ingredient_params
        params.permit(:id)
    end
end
