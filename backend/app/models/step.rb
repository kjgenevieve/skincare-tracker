class Step < ApplicationRecord
    belongs_to :routine
    has_one :user, through: :routine
    belongs_to :user_product    
end
