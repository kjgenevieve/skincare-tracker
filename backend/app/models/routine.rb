class Routine < ApplicationRecord
    belongs_to :user
    has_many :steps
    has_many :user_products, through: :steps    
end
