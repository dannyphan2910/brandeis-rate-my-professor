class RateDown < ApplicationRecord
    has_and_belongs_to_many :users 
    validates :user_id, uniqueness: { scope: [:review_id] }
end
