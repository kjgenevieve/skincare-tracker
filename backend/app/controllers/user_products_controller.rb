class UserProductsController < ApplicationController
    def index
        render json: UserProduct.all
    end

    def show
        render json: UserProduct.find(params[:id])
    end

    def create
        @user_products = UserProduct.new(user_products_params)
        @user_products.save
        render :json => @user_products
    end

    # def edit
    #     @cache = Cache.find(params[:id])
    # end

    # def update
    #     @cache = Cache.find(params[:id])
    #     @cache.update(cache_params)
    #     render :json => @cache
    # end

    def destroy
        @user_products = UserProduct.find(params[:id])
        @user_products.destroy
    end 

    def user_products_params
        params.permit(:id, :user_id, :product_id, :current, :rating, :wishlist, :opened, :expires, :caused_acne, :notes)
    end
end
