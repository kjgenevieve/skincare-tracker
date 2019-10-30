class UserProductsController < ApplicationController
    def index
        render json: UserProduct.all
    end

    def show
        render json: UserProduct.find(params[:id])
    end
end
