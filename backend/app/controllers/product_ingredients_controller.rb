class ProductIngredientsController < ApplicationController
    def index
        render json: ProductIngredient.all
    end

    def show
        render json: ProductIngredient.find(params[:id])
    end
end
