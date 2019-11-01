class UserProduct < ApplicationRecord
    belongs_to :user
    belongs_to :product
    has_many :steps
end