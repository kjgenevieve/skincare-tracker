class ProductIngredient < ApplicationRecord
    belongs_to :product
    belongs_to :ingredient    


    def average_rating
        ratings = histories.map {|history| history.rating}
        ratings.inject{ |sum, el| sum + el }.to_f / ratings.length
    end

    # def ingredients
    #     # All ingredients where the product matches
    # end

end
