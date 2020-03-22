class Course < ApplicationRecord
    has_many :reviews
    belongs_to :professor
    has_many :course_ratings, through: :reviews
end
