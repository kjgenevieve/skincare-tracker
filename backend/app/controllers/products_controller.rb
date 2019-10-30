class ProductsController < ApplicationController
    def index
        render json: Product.all
    end

    def show
        render json: Product.find(params[:id])
    end
end
