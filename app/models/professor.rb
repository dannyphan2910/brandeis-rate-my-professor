class Professor < ApplicationRecord
    has_many :reviews
    has_many :courses
    has_many :professor_ratings, through: :reviews
end
