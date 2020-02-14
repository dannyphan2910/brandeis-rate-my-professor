class Review < ApplicationRecord
    belongs_to :user
    has_many :gets
    has_many :courses, through: :gets
end
