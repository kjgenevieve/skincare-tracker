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
        @user_product = UserProduct.find(params[:id])
        @user_product.destroy
    end 

    def user_products_params
        params.permit(:id, :user_id, :product_id, :current, :rating, :wishlist, :opened, :expires, :caused_acne, :notes)
    end

    def user_reviews
        params.permit(:user_id)
        
        user_reviews = UserProduct.where(user_id: params[:user_id])
        
        product_reviews = []
        
        user_reviews.map do |review|
            product_reviews << {user_review: review, product: review.product}
        end
        
        

        render json: {
            user_id: params[:user_id],
            product_reviews: product_reviews
        }
    end
end