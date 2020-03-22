class Review < ApplicationRecord
    belongs_to :user
    belongs_to :course
    has_one :course_rating
    has_one :professor_rating

    accepts_nested_attributes_for :course_rating, :professor_rating
end
