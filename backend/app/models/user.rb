class User < ApplicationRecord
    has_many :journal_entries
    has_many :routines
    has_many :steps through: :routines
    has_many :user_products
    has_many :products through: :user_product    
end
