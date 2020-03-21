class Review < ApplicationRecord
    belongs_to :user
    belongs_to :course
    has_one :course_rating
    has_one :professor_rating
end
